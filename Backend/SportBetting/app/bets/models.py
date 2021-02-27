from app import db


class Bet (db.Model):
    id = db.Column(db.String(32), primary_key=True)
    userID = db.Column(db.String(32))
    bookieID = db.Column(db.String(32))
    amount = db.Column(db.Float)
    outcome = db.Column(db.Integer)
