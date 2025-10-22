import os

import model
from model import *
from bottle import Bottle, request, redirect, run, template, static_file, response, route, hook
import pandas as pd


app = Bottle()

auto_fucker_access_record = pd.DataFrame({
    'ip':pd.Series(dtype='str'),
    'access_time':pd.Series(dtype='datetime64[ns]')
})

# 静态文件路由
@app.route('/static/<filepath:path>')
def serve_static(filepath):
    static_folder = os.path.join(os.path.dirname(__file__), 'views', 'static')
    return static_file(filepath, root=static_folder)


@app.route('/api/auto_fucker', method='GET')
def api_auto_fucker():
    global auto_fucker_access_record

    client_ip = str(request.environ.get('REMOTE_ADDR'))

    current_time = time.time()

    mask = auto_fucker_access_record['ip'].str.contains(client_ip,na=False)

    if(client_ip!='127.0.0.1'):
        if (mask.any() == True):
            if (current_time - auto_fucker_access_record.loc[mask, 'access_time'] < 1).any():
                return {
                    'status_code': -1,
                    'response': 'Accessing the api too fast.'
                }
            auto_fucker_access_record.loc[mask, 'access_time'] = current_time
        else:
            auto_fucker_access_record = pd.concat([
                auto_fucker_access_record,
                pd.DataFrame({
                    'ip': [client_ip],
                    'access_time': [current_time]
                })
            ], ignore_index=True)

    input_sentence = request.query.getunicode('input_sentence')
    return {
        'status_code':1,
        'output_sentence':model.AutoFuckerAdapter.generate_sentence(input_sentence)
    }

@app.route('/')
def page_display():
    return template('display')



if __name__ == '__main__':
    run(app, host='localhost', port=8080)
