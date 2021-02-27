from app import db
from flask_login import UserMixin


class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    public_id = db.Column(db.String(32), unique=True)
    username = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(80))
    balance = db.Column(db.Float)
    email = db.Column(db.String(30))
    phoneNo = db.Column(db.String(15))
