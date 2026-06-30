import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/otp_bloc.dart';
import '../../widgets/code_input.dart';
import '../../widgets/feature_icon.dart';

class TwoFANotifPage extends StatefulWidget {
  final String mode;
  const TwoFANotifPage({super.key, this.mode = 'login'});
  @override
  State<TwoFANotifPage> createState() => _TwoFANotifPageState();
}

class _TwoFANotifPageState extends State<TwoFANotifPage> {
  String _otpCode = '';
  bool _otpError = false;
  bool _approved = false;

  int _resendTimer = AppConstants.otpResendSeconds;
  Timer? _countdown;

  @override
  void initState() {
    super.initState();
    context.read<OtpBloc>().add(OtpSendFirebase());
    _startTimer();
  }

  @override
  void dispose() {
    _countdown?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdown?.cancel();
    setState(() => _resendTimer = AppConstants.otpResendSeconds);
    _countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendTimer <= 0) {
        t.cancel();
      } else {
        setState(() => _resendTimer--);
      }
    });
  }

  void _resend() {
    context.read<OtpBloc>().add(OtpSendFirebase());
    setState(() => _otpCode = '');
    _startTimer();
  }

  void _onOtpChanged(String v) {
    setState(() {
      _otpCode = v;
      _otpError = false;
    });
    if (v.length == AppConstants.otpLength) {
      context.read<OtpBloc>().add(OtpConfirm(code: v, otpType: AppConstants.otpTypeFirebase));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          setState(() => _approved = true);
          Future.delayed(const Duration(milliseconds: 900), () {
            if (mounted) context.go('/home');
          });
        } else if (state is OtpInvalid) {
          setState(() {
            _otpError = true;
            _otpCode = '';
          });
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) setState(() => _otpError = false);
          });
        } else if (state is OtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.ink),
                  onPressed: () => context.go(widget.mode == 'setup' ? '/setup-2fa' : '/login'),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      FeatureIcon(
                        icon: _approved
                            ? Icons.verified_user_outlined
                            : Icons.notifications_outlined,
                        tone: 'green',
                        size: 82,
                        iconSize: 40,
                      ),
                      const SizedBox(height: 26),
                      Text(
                        _approved ? 'Disetujui!' : 'Cek notifikasi kamu',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                          letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _approved
                            ? 'Identitas terverifikasi. Mengarahkan…'
                            : 'Masukkan kode OTP yang dikirim ke notifikasi perangkat kamu.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14.5,
                          color: AppColors.slate500,
                          height: 1.55,
                        ),
                      ),
                      if (!_approved) ...[
                        const SizedBox(height: 32),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 80),
                          transform: _otpError
                              ? (Matrix4.identity()..translateByDouble(8.0, 0, 0, 1))
                              : Matrix4.identity(),
                          child: CodeInput(
                            value: _otpCode,
                            onChanged: _onOtpChanged,
                            hasError: _otpError,
                          ),
                        ),
                        if (_otpError) ...[
                          const SizedBox(height: 12),
                          const Text('Kode OTP salah, silakan coba lagi',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                color: AppColors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                        const SizedBox(height: 32),
                        _resendTimer > 0
                            ? Text(
                                'Kirim ulang dalam 00:${_resendTimer.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 13.5, color: AppColors.slate400),
                              )
                            : TextButton(
                                onPressed: _resend,
                                child: const Text(
                                  'Tidak menerima notifikasi? Kirim ulang',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
