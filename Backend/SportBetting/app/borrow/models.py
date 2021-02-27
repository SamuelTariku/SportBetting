from app import db


class Borrow(db.Model):
    borrowid = db.Column(db.Integer, primary_key=True)
    userID = db.Column(db.String(32))
    borrowAmount = db.Column(db.Float)
    borrowStatus = db.Column(db.Boolean)
    borrowOption = db.Column(db.String(32))
