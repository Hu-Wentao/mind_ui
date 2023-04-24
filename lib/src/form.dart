import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// 密码输入框
class AuthPasswordField extends StatelessWidget {
  final String name;
  final String label;
  final String hint;

  const AuthPasswordField({
    Key? key,
    this.name = 'password',
    this.label = '密码',
    this.hint = '请输入密码',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]*")),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.match(
          "[a-zA-Z]",
          errorText: "必须包含大小写字母",
        ),
        FormBuilderValidators.match(
          "[0-9]",
          errorText: "必须包含数字",
        ),
        FormBuilderValidators.required(errorText: '请输入密码'),
        FormBuilderValidators.minLength(6, errorText: "长度不能小于6"),
        FormBuilderValidators.maxLength(16, errorText: "长度不能大于16"),
        FormBuilderValidators.match(
          "[a-zA-Z0-9]{6,16}",
          errorText: "只允许6到16位的大小写字母或数字",
        ),
      ]),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

/// 手机号输入框
class AuthPhoneField extends StatelessWidget {
  final String name;
  final String? initialValue;

  const AuthPhoneField({Key? key, this.name = 'phone', this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) => FormBuilderTextField(
        name: name,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: '请输入手机号'),
          FormBuilderValidators.match("^1[0-9]{10}", errorText: "请输入正确的手机号"),
        ]),
        decoration: const InputDecoration(
            labelText: "手机号码",
            hintText: "请输入手机号码",
            // isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder()),
      );
}

/// 邮箱输入框
class AuthEmailField extends StatelessWidget {
  final String name;
  final String? initialValue;

  const AuthEmailField({Key? key, this.name = 'email', this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) => FormBuilderTextField(
        name: name,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: '请输入邮箱地址'),
          FormBuilderValidators.email(errorText: '请输入正确邮箱地址'),
        ]),
        decoration: const InputDecoration(
            labelText: "邮箱地址",
            hintText: "请输入邮箱地址",
            // isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder()),
      );
}
