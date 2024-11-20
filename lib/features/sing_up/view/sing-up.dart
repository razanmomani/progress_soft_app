
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/extension/nav_extensions.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/widgets/buttons/custom_button.dart';
import 'package:progress_soft_app/core/widgets/general/custom_buttom_sheet.dart';
import 'package:progress_soft_app/core/widgets/general/custom_loading.dart';
import 'package:progress_soft_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:progress_soft_app/features/login/view/login_screen.dart';
import 'package:progress_soft_app/features/sing_up/view_model/bloc/sing_up_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SingUpView extends StatefulWidget {
  SingUpView({super.key});

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingUpBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              tr('signUp'),
            ),
            backgroundColor: Colors.white,
          ),
          body:
              BlocConsumer<SingUpBloc, SingUpState>(listener: (context, state) {
            final phoneAuthBloc = context.read<SingUpBloc>();
            if (state is PhoneAuthLoading) {
              showDailogWithLoadingIndecator(context);
            } else if (state is PhoneAuthError) {
              context.pop();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is PhoneAuthSuccses) {
              context.pop();
              customOtpButtonSheet(
                context,
                controller: phoneAuthBloc.otpController,
                formKey: phoneAuthBloc.otpFormKey,
                onPressed: () {
                  phoneAuthBloc.verifyCode();
                },
              );
            } else if (state is PhoneVerifyCodeSuccses) {
              context.pushAndRemoveAll(LoginScreen());
            }
          }, builder: (context, state) {
            final phoneAuthBloc = context.read<SingUpBloc>();
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: phoneAuthBloc.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IntlPhoneField(
                        initialCountryCode: 'JO',
                        controller: phoneAuthBloc.phoneController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                          label: Text(
                            tr('phone'),
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
                          phoneAuthBloc.countryCode = value.countryCode;
                        },
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return tr('pleasePhone');
                          } else if (!RegExp(r'^\+\d{1,14}$')
                              .hasMatch(value.completeNumber)) {
                            return 'The phone number format is incorrect';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: phoneAuthBloc.fullNameController,
                        label: tr('fullName'),
                        textInputType: TextInputType.text,
                        suffixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('pleaseName');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: phoneAuthBloc.ageController,
                        label: tr('age'),
                        textInputType: TextInputType.number,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('pleaseAge');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: phoneAuthBloc.selectGender,
                        decoration: InputDecoration(
                          labelText: tr('chooseGender'),
                          labelStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text(tr('male')),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text(tr('female')),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            phoneAuthBloc.selectGender = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return tr('selectGender');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: phoneAuthBloc.passwordController,
                        label: tr('password'),
                        textInputType: TextInputType.text,
                        obscureText: true,
                        suffixIcon: const Icon(Icons.lock_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('pleasePassword');
                          } else if (value.length < 6) {
                            return tr('passwordCharacters');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: phoneAuthBloc.confirmPasswordController,
                        label: tr('confirmPassword'),
                        textInputType: TextInputType.text,
                        obscureText: true,
                        suffixIcon: const Icon(Icons.lock_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('confirmPassw');
                          } else if (value !=
                              phoneAuthBloc.passwordController.text) {
                            return tr('passwordsMatch');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 90),
                      CustomElevatedButton(
                        onPressed: () {
                          if (phoneAuthBloc.formKey.currentState?.validate() ??
                              false) {
                            if (phoneAuthBloc.phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(tr('pleasePhone'))),
                              );
                            } else {
                              phoneAuthBloc.sentCode();
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(tr('pleaseFillAll'))),
                            );
                          }
                        },
                        child: Text(
                          tr('signUp'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tr('alreadyAccount')),
                          InkWell(
                            onTap: () {
                              context.push(LoginScreen());
                            },
                            child: Text(
                              tr('login'),
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
          }),
        ),
      ),
    );
  }
}
