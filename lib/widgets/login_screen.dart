import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool loginSelected = true;
  bool showPassword = false;
  bool showConfirmPassword = false;
  late AnimationController controller; // AnimationController değişkeni

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 6), // Animasyon süresini ayarlayın
      vsync:
          this, // SingleTickerProviderStateMixin kullanıyorsanız, this olarak ayarlayın
    )..repeat(); // Animasyonun sürekli olarak tekrarlanmasını sağlayın
  }

  @override
  void dispose() {
    controller.dispose(); // Animasyon kontrolcüsünü dispose edin
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.orange])),
          child: Stack(
            children: [
              Positioned(top: 50, left: 100, child: customContainer(100, 100)),
              Positioned(top: 50, right: 70, child: customContainer(150, 150)),
              Positioned(
                  top: 130, right: 150, child: customContainer(100, 100)),
              Positioned(top: 150, right: 10, child: customContainer(50, 50)),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    emailField(),
                    passwordField(),
                    !loginSelected ? const SizedBox() : forgotPassword(),
                    loginSelected ? const SizedBox() : confirmPasswordField(),
                    !loginSelected
                        ? const SizedBox(
                            height: 40,
                          )
                        : const SizedBox(),
                    button(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.orange])),
                        child: Row(
                          children: [
                            !loginSelected
                                ? Expanded(
                                    child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // ignore: avoid_print
                                          ('tap');
                                          loginSelected = true;
                                        });
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ))
                                : Expanded(
                                    child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        gradient: const LinearGradient(colors: [
                                          Colors.purple,
                                          Colors.orange
                                        ])),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            loginSelected
                                ? Expanded(
                                    child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          // ignore: avoid_print
                                          print('tap');
                                          loginSelected = false;
                                        });
                                      },
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ))
                                : Expanded(
                                    child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        gradient: const LinearGradient(colors: [
                                          Colors.purple,
                                          Colors.orange
                                        ])),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer(height, width) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(
          controller), // AnimationController kullanarak açıyı güncelleyin
      child: Container(
          height: double.parse(height.toString()),
          width: double.parse(width.toString()),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.purple, Color.fromARGB(255, 247, 218, 0)]))),
    );
  }

  Widget emailField() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: 16),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              hintText: 'Enter email',
              hintStyle: TextStyle(color: Colors.white70, fontSize: 15),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60, width: .4)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: .4))),
        ));
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
      child: TextField(
        obscureText: showPassword ? false : true,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(minWidth: 24),
            suffixIconConstraints: const BoxConstraints(minWidth: 24),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.lock,
                color: Colors.white,
                size: 22,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ),
            hintText: 'Enter password',
            hintStyle: const TextStyle(color: Colors.white70, fontSize: 15),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white60, width: .4)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70, width: .4))),
      ),
    );
  }

  Widget confirmPasswordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
        child: TextField(
            obscureText: showConfirmPassword ? false : true,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(minWidth: 24),
                suffixIconConstraints: const BoxConstraints(minWidth: 24),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    },
                    child: Icon(
                      showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
                hintText: 'Confirm password',
                hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white60, width: .4)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white70, width: 14)))));
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 58, bottom: 30),
        child: InkWell(
          onTap: () {
            //navigate to other screen
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Clicked')));
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 60).copyWith(bottom: 15),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3, 3),
                  blurRadius: 4,
                  spreadRadius: 1,
                  color: Colors.black12.withOpacity(0.8))
            ],
            borderRadius: BorderRadius.circular(50)
                .copyWith(topRight: const Radius.circular(0)),
            gradient:
                const LinearGradient(colors: [Colors.orange, Colors.purple])),
        child: Text(
          loginSelected ? 'Sign In' : 'Register',
          style: const TextStyle(
              color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
