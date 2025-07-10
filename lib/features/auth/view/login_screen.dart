import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/auth/widgets/widgets.dart';
import 'package:dental_crm_flutter_front/repositories/auth/auth_repository.dart';
import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository authRepository;
  const LoginScreen({super.key, required this.authRepository});

  @override
  State<LoginScreen> createState() => _LoginScreenState(authRepository);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState(this.authRepository);
  final AuthRepository authRepository;
  late AuthBloc authBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    authBloc = AuthBloc(widget.authRepository);

    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _onLoginButtonPresed(BuildContext context) {
    LoginRequest loginRequest;
    loginRequest = LoginRequest(
        email: _emailController.text, password: _passwordController.text);
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(loginRequest));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ResponsiveWidget.isSmallScreen(context)
                  ? const SizedBox()
                  : Expanded(
                      child: Container(
                        height: height,
                        color: AppColors.mainBlueColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Стоматологічний кабінет',
                                style: AppStyles.ralewayStyle.copyWith(
                                    fontSize: 48.0,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                '',
                                style: AppStyles.ralewayStyle.copyWith(
                                    fontSize: 48.0,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Expanded(
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      final error = state.error;
                      MotionToast.error(
                              title: const Text("Щось пішло не так"),
                              description: const Text(
                                  "Перeвірте чи все ви ввели правильно"))
                          .show(context);
                      print(error);
                    }
                    if (state is AuthSuccess) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/patients', (Route<dynamic> route) => false);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return _buildLoginScreen(height, context, width);
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  bool _isPasswordVisible = false;
  SingleChildScrollView _buildLoginScreen(
      double height, BuildContext context, double width) {
    return SingleChildScrollView(
        child: Container(
      height: height,
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context)
              ? height * 0.02
              : height * 0.12),
      color: AppColors.backColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context)
                  ? height * 0.15
                  : height * 0.2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Вхід до',
                  style: AppStyles.ralewayStyle.copyWith(
                      fontSize: 35.0,
                      color: AppColors.blueDarkColor,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                    text: ' особистого кабінету',
                    style: AppStyles.ralewayStyle.copyWith(
                        fontSize: 35.0,
                        color: AppColors.blueDarkColor,
                        fontWeight: FontWeight.w800))
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            ResponsiveWidget.isSmallScreen(context)
                ? 'Введіть пошту та ваш пароль для того, щоб зайти до особистого кабінету'
                : 'Введіть пошту та ваш пароль для того,\nщоб зайти до особистого кабінету',
            style: AppStyles.ralewayStyle.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: height * 0.02),
          Column(
            children: [
              Text(
                'Не зареєстровані?',
                style: AppStyles.ralewayStyle.copyWith(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text(
                  'Зареєструватися',
                  style: AppStyles.ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.mainBlueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.064),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
            child: Text(
              'Е-пошта',
              style: AppStyles.ralewayStyle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
          ),
          FormTextField(
            controller: _emailController,
            height: height,
            width: width,
            hintText: 'Е-пошта',
            icon: const Icon(Icons.email_outlined),
          ),
          SizedBox(height: height * 0.015),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
            child: Text(
              'Пароль',
              style: AppStyles.ralewayStyle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
          ),
          FormPasswordField(
            controller: _passwordController,
            height: height,
            width: width,
            hintText: 'Пароль',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible =
                      !_isPasswordVisible; // Toggle the visibility state
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            obscureText: !_isPasswordVisible,
          ),
          SizedBox(height: height * 0.05),
          AuthButton(
            text: 'Увійти',
            color: AppColors.mainBlueColor,
            onTap: () async {
              var email = _emailController.text;
              var password = _passwordController.text;

              if (email.isEmpty || password.isEmpty) {
                MotionToast.error(
                        title: const Text("Щось пішло не так"),
                        description:
                            const Text("Поля вводу не можуть бути пустими"))
                    .show(context);
                return;
              } else {
                _onLoginButtonPresed(context);
              }

              // final email = _emailController.text;
              // final password = _passwordController.text;

              // final loginRequest = LoginRequest(
              //     email: email, password: password);
              // authBloc.add(LoginEvent(loginRequest));
            },
          )
        ],
      ),
    ));
  }
}
