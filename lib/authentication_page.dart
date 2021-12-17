// Created by Muhamad Fauzi Ridwan on 22/11/21.

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'core/bases/states/_states.dart';
import 'core/constants/_constants.dart';
import 'core/theme/_theme.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HeightSpace(size.height * .15),
            RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Ulas',
                    style: FontTheme.poppins24w700black(),
                  ),
                  TextSpan(
                    text: 'Kelas',
                    style: FontTheme.poppins24w700black().copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const HeightSpace(10),
            Text(
              '''
Aplikasi ulasan mata kuliah Fasilkom UI.\nMasuk dan buat ulasanmu sekarang!''',
              style: FontTheme.poppins14w400black(),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: size.width * .5,
                  maxWidth: size.width * .8,
                ),
                child: Image.asset(
                  Ilustration.login,
                ),
              ),
            ),
            OnReactive(
              () => AutoLayoutButton(
                text: 'Masuk Dengan SSO',
                onTap: _ssoLogin,
                isLoading: auth.state.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _ssoLogin() async {
    unawaited(auth.setState((s) {
      s.isLoading = true;
    }));
    await Future.delayed(const Duration(seconds: 1));

    await auth.setState((s) => s.ssoLogin());
  }
}

void unawaited(Future<dynamic> future) {}