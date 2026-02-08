import 'package:bridge/features/auth/presentation/providers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInControllerProvider);

    /// build가 여러 번 실행되어도 알아서 중복 구독을 방지함. 필요할 때만 리스너를 실행
    /// build 안에서 프로바이더의 상태를 구독해야함
    ref.listen(signInControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    ref.read(signInControllerProvider.notifier).signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  },
            child: state.isLoading //
                ? const CircularProgressIndicator()
                : const Text('Sign in'),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
