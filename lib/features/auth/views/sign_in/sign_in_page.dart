import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/widgets/primary_button.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: Padding(
          padding: DDimension.bigPadding.all,
          child: Column(
            children: [
              const Spacer(),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(label: Text("Email")),
              ),
              DDimension.bigPadding.verticalBox,
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              DDimension.bigPadding.verticalBox,
              PrimaryButton(
                onTap: () {},
                title: Text("Sign in"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
