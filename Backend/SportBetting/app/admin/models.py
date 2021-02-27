from app import db
from flask_login import UserMixin


class Admin(UserMixin, db.Model):
    id = db.Column(db.String(32), primary_key=True)
    username = db.Column(db.String(15), unique=True)
    password = db.Column(db.String(80))
