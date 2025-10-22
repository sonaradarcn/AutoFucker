<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonaradar Auto Fucker</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #ffffff;
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* 背景装饰元素 */
        .bg-decoration {
            position: absolute;
            border-radius: 50%;
            opacity: 0.05;
            z-index: 0;
        }

        .bg-1 {
            width: 300px;
            height: 300px;
            background: linear-gradient(135deg, #4a00e0, #8e2de2);
            top: -150px;
            right: -150px;
        }

        .bg-2 {
            width: 200px;
            height: 200px;
            background: linear-gradient(135deg, #8e2de2, #4a00e0);
            bottom: -100px;
            left: -100px;
        }

        .floating-container {
            width: 50%;
            min-width: 500px;
            background-color: #e6f7ff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(74, 0, 224, 0.15);
            overflow: hidden;
            position: relative;
            z-index: 1;
            animation: floatIn 0.8s ease-out forwards;
            transform: translateY(30px);
            opacity: 0;
        }

        @keyframes floatIn {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        header {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            color: white;
            padding: 25px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: pulse 8s infinite linear;
        }

        @keyframes pulse {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
            animation: textGlow 3s infinite alternate;
        }

        @keyframes textGlow {
            from {
                text-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
            }
            to {
                text-shadow: 0 0 15px rgba(255, 255, 255, 0.8), 0 0 20px rgba(255, 255, 255, 0.6);
            }
        }

        .subtitle {
            font-size: 1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .content {
            padding: 30px;
        }

        .input-group {
            margin-bottom: 25px;
            animation: slideInLeft 0.6s ease-out 0.2s forwards;
            transform: translateX(-20px);
            opacity: 0;
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #4a00e0;
        }

        textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #93d2ff;
            border-radius: 10px;
            font-size: 1rem;
            resize: vertical;
            /*min-height: 120px;*/
            transition: all 0.3s;
            background-color: rgba(255, 255, 255, 0.7);
        }

        textarea:focus {
            outline: none;
            border-color: #4a00e0;
            box-shadow: 0 0 0 3px rgba(74, 0, 224, 0.1);
            transform: translateY(-2px);
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            animation: slideInRight 0.6s ease-out 0.4s forwards;
            transform: translateX(20px);
            opacity: 0;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        button {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        button::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        button:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .generate-btn {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            color: white;
        }

        .generate-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(142, 45, 226, 0.4);
        }

        .clear-btn {
            background-color: rgba(255, 255, 255, 0.7);
            color: #666;
            border: 2px solid #b3e0ff;
        }

        .clear-btn:hover {
            background-color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .result-container {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            border-left: 5px solid #4a00e0;
            animation: fadeIn 0.8s ease-out 0.6s forwards;
            opacity: 0;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .result-title {
            font-weight: 600;
            margin-bottom: 10px;
            color: #4a00e0;
        }

        .result-text {
            line-height: 1.6;
            min-height: 60px;
            transition: all 0.3s;
        }

        .result-text.updated {
            animation: textUpdate 0.5s ease-out;
        }

        @keyframes textUpdate {
            0% {
                background-color: transparent;
            }
            50% {
                background-color: rgba(74, 0, 224, 0.1);
            }
            100% {
                background-color: transparent;
            }
        }

        .loading {
            display: none;
            text-align: center;
            margin: 20px 0;
            animation: pulse 2s infinite;
        }

        .spinner {
            border: 4px solid rgba(74, 0, 224, 0.1);
            border-left-color: #4a00e0;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 15px;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .error-message {
            color: #e74c3c;
            background-color: #ffeaea;
            padding: 10px 15px;
            border-radius: 8px;
            margin-top: 15px;
            display: none;
            animation: shake 0.5s ease-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-5px); }
            40%, 80% { transform: translateX(5px); }
        }

        .success-message {
            color: #27ae60;
            background-color: #eaffea;
            padding: 10px 15px;
            border-radius: 8px;
            margin-top: 15px;
            display: none;
            animation: successPop 0.5s ease-out;
        }

        @keyframes successPop {
            0% { transform: scale(0.9); opacity: 0; }
            70% { transform: scale(1.05); opacity: 1; }
            100% { transform: scale(1); opacity: 1; }
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 0.9rem;
            border-top: 1px solid rgba(179, 224, 255, 0.5);
        }

        /* 响应式设计 */
        @media (max-width: 1100px) {
            .floating-container {
                width: 70%;
            }
        }

        @media (max-width: 768px) {
            .floating-container {
                width: 85%;
                min-width: unset;
            }
        }

        @media (max-width: 600px) {
            .floating-container {
                width: 95%;
                border-radius: 15px;
            }

            header {
                padding: 20px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .content {
                padding: 20px;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- 背景装饰元素 -->
    <div class="bg-decoration bg-1"></div>
    <div class="bg-decoration bg-2"></div>

    <!-- 主容器 -->
    <div class="floating-container">
        <header>
            <h1>Auto Fucker</h1>
            <p class="subtitle">本地API调用格式:http://localhost:8080/api/auto_fucker?input_sentence=xxx</p>
        </header>

        <div class="content">
            <div class="input-group">
                <label for="input-text">请输入文本：</label>
                <textarea id="input-text" placeholder="在此输入您想要扩展的文本内容..."></textarea>
            </div>

            <div class="button-group">
                <button class="generate-btn" id="generate-btn">生成文本</button>
                <button class="clear-btn" id="clear-btn">清空内容</button>
            </div>

            <div class="loading" id="loading">
                <div class="spinner"></div>
                <p>AI正在生成文本，请稍候...</p>
            </div>

            <div class="error-message" id="error-message"></div>
            <div class="success-message" id="success-message"></div>

            <div class="result-container">
                <div class="result-title">生成结果：</div>
                <div class="result-text" id="result-text">生成的内容将显示在这里...</div>
            </div>
        </div>

        <footer>
            <p>Sonaradar Auto Fucker Model is powered by LSTM.</p>
            <p>Sonaradar Auto Fucker &copy; 2025 Sonaradar Electric LLC. All Rights Reserved.</p>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const generateBtn = document.getElementById('generate-btn');
            const clearBtn = document.getElementById('clear-btn');
            const inputText = document.getElementById('input-text');
            const resultText = document.getElementById('result-text');
            const loading = document.getElementById('loading');
            const errorMessage = document.getElementById('error-message');
            const successMessage = document.getElementById('success-message');

            // 生成文本函数
            generateBtn.addEventListener('click', async function() {
                const text = inputText.value.trim();

                if (!text) {
                    showError('请输入要扩展的文本内容！');
                    return;
                }

                // 显示加载状态
                loading.style.display = 'block';
                errorMessage.style.display = 'none';
                successMessage.style.display = 'none';
                resultText.textContent = '生成的内容将显示在这里...';

 try {
                    // 调用后端API
                    const response = await fetch(`/api/auto_fucker?input_sentence=${encodeURIComponent(text)}`);
                    const data = await response.json();

                    if (data.status_code === 1) {
                        resultText.textContent = data.output_sentence;
                        showSuccess('文本生成成功！');
                    } else {
                        showError(data.response || '生成失败，请稍后重试。');
                    }
                } catch (error) {
                    console.error('API调用错误:', error);
                    showError('网络错误，请检查连接后重试。');
                } finally {
                    loading.style.display = 'none';
                }
            });

            // 清空内容函数
            clearBtn.addEventListener('click', function() {
                inputText.value = '';
                resultText.textContent = '生成的内容将显示在这里...';
                errorMessage.style.display = 'none';
                successMessage.style.display = 'none';
            });

            // 显示错误信息
            function showError(message) {
                errorMessage.textContent = message;
                errorMessage.style.display = 'block';
                successMessage.style.display = 'none';
            }

            // 显示成功信息
            function showSuccess(message) {
                successMessage.textContent = message;
                successMessage.style.display = 'block';
                errorMessage.style.display = 'none';
            }
        });
    </script>
</body>
</html>