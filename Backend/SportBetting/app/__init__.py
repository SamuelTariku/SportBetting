from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bootstrap import Bootstrap
from flask_login import LoginManager

db = SQLAlchemy()
login_manager = LoginManager()


def create_app(config_file):
    app = Flask(__name__)
    app.config.from_pyfile(config_file)

    # Initialize plugins
    db.init_app(app)
    Bootstrap(app)
    login_manager.init_app(app)

    with app.app_context():

        from app.admin.controller import admin
        app.register_blueprint(admin)

        from app.users.controller import user
        app.register_blueprint(user)

        from app.games.controller import games
        app.register_blueprint(games)

        from app.bets.controller import bets
        app.register_blueprint(bets)

        from app.bookie.controller import bookie
        app.register_blueprint(bookie)

        from app.borrow.controller import borrow
        app.register_blueprint(borrow)

        db.create_all()

        return app


@login_manager.user_loader
def load_user(user_id):
    from app.admin.models import Admin
    x = Admin.query.get(user_id)

    if(x == None):
        pass

    return x
