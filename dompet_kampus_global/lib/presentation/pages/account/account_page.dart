import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../injection/injection_container.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/pin_pad.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go('/');
        }
      },
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).padding.top + 12, 20, 24),
                  child: Row(
                    children: [
                      AppAvatar(name: user?.name ?? 'User', size: 60, bg: Colors.white.withValues(alpha: 0.25)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.name ?? 'Pengguna',
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            Text(user?.email ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 13,
                                  color: Colors.white70,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_user_outlined, size: 14, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Terverifikasi',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 8),
                        child: Text('Keamanan',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate400,
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: AppColors.shadowSoft,
                        ),
                        child: Column(
                          children: [
                            _Row(
                              icon: Icons.verified_user_outlined,
                              tone: 'green',
                              title: 'Verifikasi 2 langkah (2FA)',
                              subtitle: 'Aktif · Email OTP',
                              onTap: () => context.go('/setup-2fa'),
                              right: const AppBadge(label: 'Aktif', tone: 'green'),
                            ),
                            const Divider(height: 1, indent: 56, color: AppColors.line2),
                            _Row(
                              icon: Icons.lock_outline_rounded,
                              tone: 'blue',
                              title: 'Ubah PIN keamanan',
                              subtitle: 'Atur atau ubah PIN transaksi',
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const _ChangePinSheet(),
                              ),
                            ),
                            const Divider(height: 1, indent: 56, color: AppColors.line2),
                            _Row(
                              icon: Icons.fingerprint_rounded,
                              tone: 'violet',
                              title: 'Login biometrik',
                              subtitle: 'Sidik jari',
                              onTap: () {},
                              right: _Toggle(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 8),
                        child: Text('Akun',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate400,
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: AppColors.shadowSoft,
                        ),
                        child: Column(
                          children: [
                            _Row(icon: Icons.person_outline_rounded, tone: 'blue', title: 'Data pribadi', onTap: () {}),
                            const Divider(height: 1, indent: 56, color: AppColors.line2),
                            _Row(icon: Icons.account_balance_outlined, tone: 'green', title: 'Rekening & kartu tersimpan', onTap: () {}),
                            const Divider(height: 1, indent: 56, color: AppColors.line2),
                            _Row(icon: Icons.settings_outlined, tone: 'slate', title: 'Pengaturan aplikasi', onTap: () {}),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppColors.shadowSoft,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded, size: 20, color: AppColors.red),
                              SizedBox(width: 9),
                              Text('Keluar',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text('daqi · Dana Zaqi · v1.0.0',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 12,
                              color: AppColors.slate400,
                            )),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String tone;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? right;

  const _Row({
    required this.icon,
    required this.tone,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Bagian kiri yang bisa di-tap (ikon + teks)
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  FeatureIcon(icon: icon, tone: tone, size: 42, iconSize: 20),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            )),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(subtitle!,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 12.5,
                                color: AppColors.slate400,
                              )),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Widget kanan (toggle / chevron) di luar GestureDetector row
          right ?? const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.slate400),
        ],
      ),
    );
  }
}

class _Toggle extends StatefulWidget {
  @override
  State<_Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<_Toggle> {
  final _biometric = BiometricService();
  bool _on = false;

  @override
  void initState() {
    super.initState();
    _biometric.isEnabled().then((v) {
      if (mounted) setState(() => _on = v);
    });
  }

  Future<void> _toggle() async {
    final available = await _biometric.isAvailable();
    if (!available && !_on) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perangkat tidak mendukung biometrik')),
        );
      }
      return;
    }

    if (!_on) {
      // Aktifkan: minta verifikasi biometrik dulu
      final passed = await _biometric.authenticate(
        reason: 'Verifikasi untuk mengaktifkan login biometrik',
      );
      if (!passed) return;
    }

    await _biometric.setEnabled(!_on);
    if (mounted) setState(() => _on = !_on);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 26,
        decoration: BoxDecoration(
          color: _on ? AppColors.green : AppColors.line,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          alignment: _on ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(3),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1))],
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────
// Bottom sheet: Atur / Ubah PIN keamanan
// ────────────────────────────────────────────────

enum _PinStep { oldPin, newPin, confirmPin }

class _ChangePinSheet extends StatefulWidget {
  const _ChangePinSheet();

  @override
  State<_ChangePinSheet> createState() => _ChangePinSheetState();
}

class _ChangePinSheetState extends State<_ChangePinSheet> {
  _PinStep _step = _PinStep.oldPin;
  String _pin = '';
  String _newPin = '';
  bool _hasExistingPin = false;
  bool _pinError = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkExistingPin();
  }

  Future<void> _checkExistingPin() async {
    final stored = await sl<SecureStorageDatasource>().getPin();
    if (!mounted) return;
    setState(() {
      _hasExistingPin = stored != null;
      // Jika belum ada PIN, langsung ke step buat PIN baru
      _step = stored != null ? _PinStep.oldPin : _PinStep.newPin;
      _loading = false;
    });
  }

  String get _title {
    switch (_step) {
      case _PinStep.oldPin:
        return 'Masukkan PIN Lama';
      case _PinStep.newPin:
        return _hasExistingPin ? 'Masukkan PIN Baru' : 'Buat PIN Baru';
      case _PinStep.confirmPin:
        return 'Konfirmasi PIN Baru';
    }
  }

  String get _subtitle {
    switch (_step) {
      case _PinStep.oldPin:
        return 'Masukkan PIN lama kamu untuk melanjutkan';
      case _PinStep.newPin:
        return 'Masukkan 6 digit PIN baru';
      case _PinStep.confirmPin:
        return 'Masukkan ulang PIN baru untuk konfirmasi';
    }
  }

  Future<void> _onComplete(String pin) async {
    final storage = sl<SecureStorageDatasource>();

    if (_step == _PinStep.oldPin) {
      final stored = await storage.getPin();
      if (stored != pin) {
        if (!mounted) return;
        setState(() { _pinError = true; _pin = ''; });
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) setState(() => _pinError = false);
        });
        return;
      }
      if (!mounted) return;
      setState(() { _step = _PinStep.newPin; _pin = ''; });
      return;
    }

    if (_step == _PinStep.newPin) {
      if (!mounted) return;
      setState(() { _newPin = pin; _step = _PinStep.confirmPin; _pin = ''; });
      return;
    }

    // confirmPin
    if (pin != _newPin) {
      if (!mounted) return;
      setState(() { _pinError = true; _pin = ''; });
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) setState(() => _pinError = false);
      });
      return;
    }

    await storage.savePin(_newPin);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('PIN berhasil disimpan'),
      backgroundColor: AppColors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottom),
      child: _loading
          ? const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.line,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(_title,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    )),
                const SizedBox(height: 6),
                Text(_subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13.5, color: AppColors.slate500)),
                if (_pinError) ...[
                  const SizedBox(height: 12),
                  Text(
                    _step == _PinStep.oldPin ? 'PIN lama salah, coba lagi' : 'PIN tidak cocok, coba lagi',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      color: AppColors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                PinPad(
                  value: _pin,
                  onChanged: (v) => setState(() => _pin = v),
                  onComplete: (pin) => _onComplete(pin),
                ),
              ],
            ),
    );
  }
}
