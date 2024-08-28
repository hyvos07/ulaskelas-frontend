// Created by Muhamad Fauzi Ridwan on 22/11/21.

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:ulaskelas/features/matkul/bookmarks/domain/entities/query_bookmark.dart';
import 'package:ulaskelas/services/_services.dart';

import 'core/bases/states/_states.dart';
import 'core/constants/_constants.dart';
import 'core/theme/_theme.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Transform.scale(
                  scale: 1.7,
                  child: Transform.translate(
                    offset: Offset(- (size.width / 20), - (size.height / 20)),
                    child: Stack(
                      children: List.generate(1, (index) {
                        return Image.asset(
                          'assets/onboarding/light_yellow.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.1,
                  child: Transform.translate(
                    offset: Offset(- (size.width / 5), size.height / 8),
                    child: Stack(
                      children: List.generate(1, (index) {
                        return Image.asset(
                          'assets/onboarding/light_purple.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Transform.translate(
                    offset: Offset(size.width / 5, size.height / 6),
                    child: Stack(
                      children: List.generate(1, (index) {
                        return Image.asset(
                          'assets/onboarding/light_pink.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: Transform.translate(
                    offset: Offset(- (size.width / 4), size.height / 3),
                    child: Stack(
                      children: List.generate(1, (index) {
                        return Image.asset(
                          'assets/onboarding/light_blue.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.75,
                  child: Transform.translate(
                    offset: Offset(size.width / 10, size.height / 2.6),
                    child: Stack(
                      children: List.generate(1, (index) {
                        return Image.asset(
                          'assets/onboarding/light_green.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          scale: 6,
                        ),
                      ),
                      const HeightSpace(10),
                      RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Teman',
                              style: FontTheme.poppins24w700black(),
                            ),
                            TextSpan(
                              text: 'Kuliah',
                              style: FontTheme.poppins24w700black().copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightSpace(10),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Your All-in-One Solution for Academic Success',
                          style: FontTheme.poppins14w500black(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                OnReactive(
                  () => AutoLayoutButton(
                    text: 'Masuk Dengan SSO',
                    onTap: _ssoLogin,
                    isLoading: authRM.state.isLoading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ssoLogin() async {
    MixpanelService.track('login');
    if (authRM.state.isLoading) {
      return;
    }
    unawaited(
      authRM.setState((s) {
        s.isLoading = true;
        return;
      }),
    );
    await Future.delayed(const Duration(seconds: 1));
    await authRM.setState((s) => s.ssoLogin());
    if (authRM.state.isLogin) {
      MixpanelService.track('login_success');
      await profileRM.state.retrieveData();
      await bookmarkRM.state.retrieveData(QueryBookmark());
      if (profileRM.state.profile.isBlocked ?? false) {
        ErrorMessenger('Your account is blocked').show(ctx!);
        return;
      }
      unawaited(nav.replaceToMainPage());
      SuccessMessenger('Login Successful').show(ctx!);
    }
    unawaited(
      authRM.setState((s) {
        s.isLoading = false;
        return;
      }),
    );
  }
}

void unawaited(Future<dynamic> future) {}
