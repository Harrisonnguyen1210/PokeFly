import 'package:flutter/material.dart';
import 'package:poke_fly/providers/auth_provider.dart';
import 'package:poke_fly/utils/error_dialog.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Signin }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Signin;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  AnimationController _animationController;
  Animation _slideAnimation;
  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Signin) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Signin;
      });
      _animationController.reverse();
    }
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      if (_authMode == AuthMode.Signin) {
        await authProvider.signIn(_authData['email'], _authData['password']);
      } else {
        await authProvider.signUp(_authData['email'], _authData['password']);
      }
    } catch (error) {
      ErrorDialog.showErrorDialog(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Poké Fly',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 36,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email here",
                  fillColor: Theme.of(context).accentColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSaved: (email) {
                  _authData['email'] = email;
                },
                validator: (email) {
                  if (email.isEmpty || !email.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password here",
                  fillColor: Theme.of(context).accentColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                onSaved: (password) {
                  _authData['password'] = password;
                },
                validator: (password) {
                  if (password.isEmpty || password.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              _authMode == AuthMode.Signin
                  ? SizedBox()
                  : FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Re-enter your password here",
                            fillColor: Theme.of(context).accentColor,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: true,
                          validator: (repassword) {
                            if (repassword != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        _isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            : Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _submit,
                  child:
                      Text(_authMode == AuthMode.Signin ? 'Signin' : 'Signup'),
                  color: Colors.blue[300],
                  textColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
        SizedBox(
          height: 4,
        ),
        FlatButton(
          onPressed: _switchAuthMode,
          child: Text(
              '${_authMode == AuthMode.Signin ? 'Signup' : 'Login'} instead'),
          textColor: Colors.blue[300],
        ),
      ],
    );
  }
}
