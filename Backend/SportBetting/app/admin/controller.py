import uuid

from flask import Flask, render_template, Blueprint, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from app import db

from .models import Admin
from .forms import LoginForm, RegisterForm
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user


admin = Blueprint('admin_control', __name__,
                  template_folder='templates')


@admin.route('/admin/login', methods=['GET', 'POST'])
def adminLogin():
    form = LoginForm()

    if form.validate_on_submit():
        user = Admin.query.filter_by(username=form.username.data).first()
        if (user):
            if check_password_hash(user.password, form.password.data):
                login_user(user, remember=form.remember.data)
                return redirect(url_for('admin_control.adminDashboard'))
        return '<h1>Incorrect username or password</h1>'

        # return "<h1>" + form.username.data + " " + form.password.data + "</h1>"

    return render_template('login.html', form=form)


@admin.route('/admin/signup', methods=['GET', 'POST'])
def adminSignUp():
    form = RegisterForm()

    if form.validate_on_submit():
        hashed_password = generate_password_hash(
            form.password.data, method='sha256')
        newAdmin = Admin(id=uuid.uuid4().hex,
                         username=form.username.data, password=hashed_password)
        db.session.add(newAdmin)
        db.session.commit()

        return "<h1>" + form.username.data + " " + form.password.data + "</h1>"

    return render_template('signup.html', form=form)


@admin.route('/admin/dashboard')
@login_required
def adminDashboard():
    return render_template('dashboard.html')



@admin.route('/admin/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('admin_control.adminLogin'))

