import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/constants/toast/toast_types.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/app/widgets/loader.dart';
import 'package:moment/features/app/widgets/primary_button.dart';
import 'package:moment/features/auth/models/user/user_model.dart';
import 'package:moment/features/auth/view_models/auth_viewmodel.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final authViewModel = ref.watch(authViewModelProvider);
    final formKey = useRef(GlobalKey<FormState>());
    final authNotifier = ref.read(authViewModelProvider.notifier);

    // Methods
    final handleSignIn = useCallback(() {
      if (formKey.value.currentState!.validate()) {
        authNotifier.signInWithEmailAndPassword(
          emailController.value.text,
          passwordController.value.text,
        );
      }
    }, [
      formKey.value,
      emailController.value.text,
      passwordController.value.text
    ]);

    final isLoading = useState(false);
    _authViewModelListener(ref, context, isLoading);
    

    return Form(
      key: formKey.value,
      child: Scaffold(
        body: Padding(
          padding: DDimension.bigPadding.all,
          child: Column(
            children: [
              const Spacer(),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(label: Text("Email")),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return "Please enter email";
                },
              ),
              DDimension.bigPadding.verticalBox,
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return "Please enter password";
                },
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              DDimension.bigPadding.verticalBox,
              PrimaryButton(
                onTap: handleSignIn,
                title: isLoading.value ? const Loader() : Text("Sign in"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _authViewModelListener(
      WidgetRef ref, BuildContext context, ValueNotifier<bool> isLoading) {
    return ref.listen<AsyncValue<UserModel?>?>(
      authViewModelProvider,
      (previous, next) {
        next?.when(
          data: (data) {
            context.router.pushAndPopUntil(
              const SnapperNavigationRoute(),
              predicate: (route) => false,
            );
            isLoading.value = false;
            snackBar(context,
                message: "Successfully signed in!",
                toastType: ToastType.success);
          },
          error: (error, _) {
            snackBar(
              context,
              message: error.toString(),
              toastType: ToastType.failure,
            );
            isLoading.value = false;
          },
          loading: () {
            isLoading.value = true;
          },
        );
      },
    );
  }
}
