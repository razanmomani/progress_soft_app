import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:progress_soft_app/core/extension/nav_extensions.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/widgets/buttons/custom_button.dart';
import 'package:progress_soft_app/core/widgets/general/custom_loading.dart';
import 'package:progress_soft_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:progress_soft_app/features/bottom_navigation_bar/bottom_navigation.dart';
import 'package:progress_soft_app/features/login/view_model/cubit/login_cubit.dart';
import 'package:progress_soft_app/features/login/view_model/cubit/login_state.dart';

import 'package:progress_soft_app/features/sing_up/view/sing-up.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
              //  context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('successLogin'))),
                );
                context.pushReplacement(const ScreenBottomNavigations());
              } else if (state is LoginLoading) {

                showDailogWithLoadingIndecator(context);

              } else if (state is LoginFailure) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr(state.error))),
                );
              }
            },
            builder: (context, state) {
              final loginCubit = context.read<LoginCubit>();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Form(
                    key: loginCubit.formKeyLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        const Center(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/images/logo_s.png'),
                          ),
                        ),
                        const SizedBox(height: 40),
                        IntlPhoneField(
                          initialCountryCode: 'JO',
                          controller: loginCubit.phoneController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black45,
                              ),
                            ),
                            label: Text(
                              tr("phone"),
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.phone_android_outlined,
                            ),
                          ),
                          onChanged: (value) {
                            loginCubit.countryCode = value.countryCode;
                          },
                          validator: (value) {
                            if (value == null || value.number.isEmpty) {
                              return tr('pleasePhone');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: loginCubit.passwordController,
                          label: tr("password"),
                          textInputType: TextInputType.text,
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('pleasePassword');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 90),
                        CustomElevatedButton(
                          onPressed: () {
                            if (loginCubit.formKeyLogin.currentState?.validate() ?? false) {
                              loginCubit.loginUser();
                            } else {
                              print('Fields are not valid');
                            }

                          },
                          child: Text(
                            tr('login'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(tr("don'tAccount")),
                            InkWell(
                              onTap: () {
                                context.push(
                                  SingUpView(),
                                );
                              },
                              child: Text(
                                tr('signUp'),
                                style: const TextStyle(
                                  color: AColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
