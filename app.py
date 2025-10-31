from flask import Flask

app = Flask(jibin)

@app.route("/")
def hello_world():
    return "<p>Hello, <<jibin>>!</p>"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)
