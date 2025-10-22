import torch
import torch.nn as nn
import torch.optim as optim
import numpy as np
import re
from collections import Counter
import random
import time
from sklearn.model_selection import train_test_split
from tqdm import tqdm


class TextGeneratorLSTM(nn.Module):
    def __init__(self, vocab_size, embedding_dim=128, hidden_dim=256, num_layers=2, dropout=0.2):
        super(TextGeneratorLSTM, self).__init__()

        self.hidden_dim = hidden_dim
        self.num_layers = num_layers
        self.vocab_size = vocab_size

        # 嵌入层
        self.embedding = nn.Embedding(vocab_size, embedding_dim)

        # LSTM层
        self.lstm = nn.LSTM(embedding_dim, hidden_dim, num_layers,
                            dropout=dropout, batch_first=True)

        # 输出层
        self.fc = nn.Linear(hidden_dim, vocab_size)
        self.dropout = nn.Dropout(dropout)

    def forward(self, x, hidden=None):
        batch_size = x.size(0)

        # 嵌入层
        x = self.embedding(x)

        # LSTM层
        lstm_out, hidden = self.lstm(x, hidden)

        # 全连接层
        output = self.fc(self.dropout(lstm_out))

        return output, hidden

    def init_hidden(self, batch_size, device):
        return (torch.zeros(self.num_layers, batch_size, self.hidden_dim).to(device),
                torch.zeros(self.num_layers, batch_size, self.hidden_dim).to(device))


class TextPredictor:
    def __init__(self, model_path=None, data_file=None, seq_length=50):
        self.seq_length = seq_length
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

        # 词汇表相关属性
        self.char_to_idx = None
        self.idx_to_char = None
        self.vocab_size = None

        if model_path and data_file:
            self.load_model_and_data(model_path, data_file)

    def load_model_and_data(self, model_path, data_file):
        # 加载模型
        self.model = TextGeneratorLSTM(
            vocab_size=1114,
            embedding_dim=128,
            hidden_dim=256,
            num_layers=2
        ).to(self.device)

        checkpoint = torch.load(model_path, map_location=self.device)
        self.model.load_state_dict(checkpoint['model_state_dict'])

        # 从检查点加载词汇表信息（如果存在）
        if 'char_to_idx' in checkpoint:
            self.char_to_idx = checkpoint['char_to_idx']
            self.idx_to_char = checkpoint['idx_to_char']
            self.vocab_size = checkpoint['vocab_size']

        self.model.eval()
        print(f"[Sonaradar-AutoFucker]模型加载成功，词汇表大小: {self.vocab_size}")

    def preprocess_input_text(self, text):
        """预处理输入文本"""
        # 简单的预处理，与训练时保持一致
        text = re.sub(r'([,.!?;:])', r' \1 ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    def generate_text(self, seed_text, max_length=200, temperature=0.8):
        """根据种子文本生成续写"""
        if self.char_to_idx is None or self.idx_to_char is None:
            raise ValueError("词汇表未初始化，请先训练模型或加载已训练的模型")

        self.model.eval()

        # 预处理输入文本
        seed_text = self.preprocess_input_text(seed_text)

        # 将种子文本转换为索引
        input_seq = [self.char_to_idx.get(char, 0) for char in seed_text]
        input_seq = input_seq[-self.seq_length:]  # 截断到最大长度

        # 填充序列
        if len(input_seq) < self.seq_length:
            input_seq = [0] * (self.seq_length - len(input_seq)) + input_seq

        generated_text = seed_text

        with torch.no_grad():
            hidden = self.model.init_hidden(1, self.device)

            for _ in range(max_length):
                # 准备输入
                input_tensor = torch.tensor([input_seq]).to(self.device)

                # 前向传播
                output, hidden = self.model(input_tensor, hidden)

                # 获取最后一个时间步的输出
                last_output = output[0, -1, :]

                # 应用温度采样
                last_output = last_output / temperature
                probabilities = torch.softmax(last_output, dim=0).cpu().numpy()

                # 采样下一个字符
                next_char_idx = np.random.choice(len(probabilities), p=probabilities)
                next_char = self.idx_to_char[next_char_idx]

                # 添加到生成文本
                generated_text += next_char

                # 更新输入序列
                input_seq = input_seq[1:] + [next_char_idx]

                # 如果遇到句子结束符，可以停止
                if next_char in '.!?。！？' and len(generated_text) > len(seed_text) + 20:
                    break

        return generated_text

    def complete_paragraph(self, incomplete_sentences, sentences_per_paragraph=5):
        """将不完整的句子补全并拼接成段落"""
        if self.char_to_idx is None:
            raise ValueError("词汇表未初始化，请先训练模型或加载已训练的模型")

        paragraph = ""

        for i, sentence in enumerate(incomplete_sentences):
            if i > 0:
                paragraph += " "

            # 生成完整的句子
            completed_sentence = self.generate_text(sentence, max_length=100)
            paragraph += completed_sentence

            # 如果达到段落要求的句子数量，停止生成
            if i >= sentences_per_paragraph - 1:
                break

        return paragraph

class AutoFuckerAdapter():
    init_flag = False
    predictor = None

    @staticmethod
    def check_init():
        if(AutoFuckerAdapter.init_flag==False):
            AutoFuckerAdapter.predictor = TextPredictor()
            AutoFuckerAdapter.predictor.load_model_and_data('SonaradarAutoFuckerModel.pth', None)
            try:
                AutoFuckerAdapter.predictor.load_model_and_data('SonaradarAutoFuckerModel.pth', None)
            except Exception as e:
                print("[Sonaradar-AutoFucker]请先训练模型或确保模型文件存在,输出:{}.".format(str(e)))
                return False
            if hasattr(AutoFuckerAdapter.predictor, 'model') and AutoFuckerAdapter.predictor.char_to_idx is not None:
                AutoFuckerAdapter.init_flag = True
                print("[Sonaradar-AutoFucker]初始化完成")
                return True
            print("[Sonaradar-AutoFucker]初始化失败")
            return False
        return True


    @staticmethod
    def generate_sentence(input_sentence):
        if(AutoFuckerAdapter.check_init()==False):
            return ""
        rst = AutoFuckerAdapter.predictor.generate_text(input_sentence, max_length=100)
        while(rst.count(' ')<=6):
            rst = rst.replace(input_sentence,'', 1).rsplit(' ', 1)[0].partition(' ')[2]
            rst = rst + ' ' + AutoFuckerAdapter.predictor.generate_text(rst.rsplit(' ', 1)[-1], max_length=100).replace(rst.rsplit(' ', 1)[-1],'', 1).rsplit(' ', 1)[0].partition(' ')[2]
        return rst