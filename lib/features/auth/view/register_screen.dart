import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/auth/widgets/widgets.dart';
import 'package:dental_crm_flutter_front/repositories/auth/auth_repository.dart';
import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthRepository authRepository = AuthRepository();
  late AuthBloc authBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    authBloc = AuthBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordVisible = false;
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
                    child: BlocProvider(
                        create: (context) => authBloc,
                        child: SingleChildScrollView(
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) async {
                              if (state is AuthSuccess) {
                                // Authentication successful, handle the response
                                final response = state.response;

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/patients',
                                    (Route<dynamic> route) => false);

                                print('Register is successful: $response');
                              } else if (state is AuthFailure) {
                                // Authentication failed, show error message
                                final error = state.error;
                                MotionToast.error(
                                        title: const Text("Щось пішло не так"),
                                        description: const Text(
                                            "Перeвірте чи все ви ввели правильно"))
                                    .show(context);
                                print(error);
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                // Show loading indicator
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                height: height,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? height * 0.032
                                            : height * 0.12),
                                color: AppColors.backColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: ResponsiveWidget.isSmallScreen(
                                                context)
                                            ? height * 0.13
                                            : height * 0.18),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Зареєструйтеся до',
                                            style: AppStyles.ralewayStyle
                                                .copyWith(
                                                    fontSize: 35.0,
                                                    color:
                                                        AppColors.blueDarkColor,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          TextSpan(
                                              text: ' особистого кабінету',
                                              style: AppStyles.ralewayStyle
                                                  .copyWith(
                                                      fontSize: 35.0,
                                                      color: AppColors
                                                          .blueDarkColor,
                                                      fontWeight:
                                                          FontWeight.w800))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 'Введіть пошту та ваш пароль для того, щоб зайти до особистого кабінету'
                                          : 'Введіть ваше ім\'я, пошту та ваш пароль для того, \nщоб зареєструватися до особистого кабінету',
                                      style: AppStyles.ralewayStyle.copyWith(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.064),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10.0),
                                      child: Text(
                                        'Ваше ім\'я',
                                        style: AppStyles.ralewayStyle.copyWith(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                    FormTextField(
                                      controller: _nameController,
                                      height: height,
                                      width: width,
                                      hintText: 'Ім\'я',
                                      icon: const Icon(
                                          Icons.account_box_outlined),
                                    ),
                                    SizedBox(height: height * 0.015),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10.0),
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
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10.0),
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
                                          _isPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                      obscureText: !_isPasswordVisible,
                                    ),
                                    SizedBox(height: height * 0.015),
                                    Text(
                                      'Вже зареєстровані?',
                                      style: AppStyles.ralewayStyle.copyWith(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/');
                                      },
                                      child: Text(
                                        'Увійти в особистий кабінет',
                                        style: AppStyles.ralewayStyle.copyWith(
                                          fontSize: 18.0,
                                          color: AppColors.mainBlueColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.05),
                                    AuthButton(
                                      text: 'Увійти',
                                      color: AppColors.mainBlueColor,
                                      onTap: () {
                                        var name = _nameController.text;
                                        var email = _emailController.text;
                                        var password = _passwordController.text;

                                        if (name.isEmpty ||
                                            email.isEmpty ||
                                            password.isEmpty) {
                                          MotionToast.error(
                                                  title: const Text(
                                                      "Щось пішло не так"),
                                                  description: const Text(
                                                      "Поля не можуть бути пустими"))
                                              .show(context);
                                          return;
                                        } else if (!email.contains('@')) {
                                          MotionToast.error(
                                                  title: const Text(
                                                      "Щось пішло не так"),
                                                  description: const Text(
                                                      "Неправильний формат електронної пошти"))
                                              .show(context);
                                          return;
                                        } else if (password.length < 8) {
                                          MotionToast.error(
                                                  title: const Text(
                                                      "Щось пішло не так"),
                                                  description: const Text(
                                                      "Пароль повинен містити не менше 8 символів"))
                                              .show(context);
                                          return;
                                        } else {
                                          final registerRequest =
                                              RegistrationRequest(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          );
                                          context.read<AuthBloc>().add(
                                              RegistrationEvent(
                                                  registerRequest));
                                        }
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )),
                  ),
                ])));
  }
}
