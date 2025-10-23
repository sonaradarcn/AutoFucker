# Sonaradar Auto Fucker
![Demo](https://github.com/sonaradarcn/AutoFucker/blob/main/demo.png?raw=true)
一款基于LSTM的扣字预测机，其核心功能如下
- 基于现有句子预测结果(结果包含大于等于7段句子，以空格分隔)。
- 支持通过API调用本模型。
## 安装流程
1.安装依赖
```cmd
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip install numpy scikit-learn tqdm bottle pandas
```
如果下载速度过慢请手动换源。

2.启动本项目，如果需要使用图形化界面请访问http://localhost:8080/。

## 补充
- 本项目建议二次开发，通过API接入程序实现对本项目的调用。API调用地址示范：http://localhost:8080/api/auto_fucker?input_sentence=。
- 本项目严格禁止用于任何违反法律法规、危害国家安全、损害公共利益、侵犯他人合法权益（包括但不限于知识产权、隐私权）以及任何扰乱社会秩序的活动。使用者须对自身行为承担全部法律责任。

<p align="center" style="font-size:12px;font-weight:bold">
    <img src="https://github.com/sonaradarcn/Sonaradar_Copyright_Assets/blob/main/SEL%20LOGO%20FULL.png?raw=true" alt="描述" style="height:48px;align-content:center;margin-left:10px;">
</p>


