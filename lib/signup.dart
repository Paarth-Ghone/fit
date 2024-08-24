import 'package:flutter/material.dart';



class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with sign-up
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signing Up...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(context),
            const SizedBox(height: 40),
            _inputFields(context),
            const SizedBox(height: 20),
            _signupButton(context),
            const SizedBox(height: 20),
            _loginText(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Fill the details to sign up",
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _inputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[800],
            filled: true,
            prefixIcon: const Icon(Icons.person, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          validator: _validateName,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            hintText: "Phone Number",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[800],
            filled: true,
            prefixIcon: const Icon(Icons.phone, color: Colors.white),
          ),
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Colors.white),
          validator: _validatePhoneNumber,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[800],
            filled: true,
            prefixIcon: const Icon(Icons.lock, color: Colors.white),
          ),
          obscureText: true,
          style: TextStyle(color: Colors.white),
          validator: _validatePassword,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[800],
            filled: true,
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
          ),
          obscureText: true,
          style: TextStyle(color: Colors.white),
          validator: _validateConfirmPassword,
        ),
      ],
    );
  }

  Widget _signupButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: _submitForm,
        child: Text('Sign Up'),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5.0,
        ),
      ),
    );
  }

  Widget _loginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () {
            // Add navigation to login screen here
            Navigator.pop(context);
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
