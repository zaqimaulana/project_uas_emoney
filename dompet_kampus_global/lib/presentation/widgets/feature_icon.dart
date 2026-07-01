import 'package:flutter/material.dart';

// Gradient per tone — icon container sekarang lingkaran bergradien
const _toneGradients = <String, List<Color>>{
  'blue'  : [Color(0xFF0267CB), Color(0xFF3395FF)], // brand blue gradient
  'cyan'  : [Color(0xFF0267CB), Color(0xFF00CEC6)], // brand blue-green signature gradient
  'green' : [Color(0xFF00B050), Color(0xFF33DFD9)], // brand green/mint gradient
  'amber' : [Color(0xFFB45309), Color(0xFFFBBF24)],
  'red'   : [Color(0xFFDC2626), Color(0xFFFB7185)],
  'violet': [Color(0xFF5B21B6), Color(0xFF8B5CF6)],
  'slate' : [Color(0xFF012B58), Color(0xFF5B6F8A)],
};

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;

  const FeatureIcon({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 52,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _toneGradients[tone] ?? _toneGradients['blue']!;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[1].withValues(alpha: 0.38),
            blurRadius: size * 0.38,
            offset: Offset(0, size * 0.12),
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}

// Map design icon names to Material icons (premium rounded style)
class DkgIcons {
  static const IconData home       = Icons.home_rounded;
  static const IconData history    = Icons.history_rounded;
  static const IconData scan       = Icons.qr_code_scanner_rounded;
  static const IconData gift       = Icons.card_giftcard_rounded;
  static const IconData user       = Icons.person_rounded;
  static const IconData send       = Icons.swap_horizontal_circle_rounded;
  static const IconData wallet     = Icons.account_balance_wallet_rounded;
  static const IconData plus       = Icons.add_rounded;
  static const IconData bell       = Icons.notifications_rounded;
  static const IconData eye        = Icons.visibility_rounded;
  static const IconData eyeOff     = Icons.visibility_off_rounded;
  static const IconData shield     = Icons.shield_rounded;
  static const IconData shieldCheck= Icons.verified_user_rounded;
  static const IconData check      = Icons.check_rounded;
  static const IconData mail       = Icons.mail_rounded;
  static const IconData lock       = Icons.lock_rounded;
  static const IconData phone      = Icons.phone_rounded;
  static const IconData copy       = Icons.copy_rounded;
  static const IconData bank       = Icons.account_balance_rounded;
  static const IconData arrowLeft  = Icons.arrow_back_ios_new_rounded;
  static const IconData arrowRight = Icons.arrow_forward_ios_rounded;
  static const IconData chevRight  = Icons.chevron_right_rounded;
  static const IconData chevDown   = Icons.keyboard_arrow_down_rounded;
  static const IconData topup      = Icons.add_card_rounded;
  static const IconData withdraw   = Icons.local_atm_rounded;
  static const IconData bill       = Icons.receipt_rounded;
  static const IconData pulsa      = Icons.phone_android_rounded;
  static const IconData pln        = Icons.electric_bolt_rounded;
  static const IconData kantin     = Icons.fastfood_rounded;
  static const IconData ukt        = Icons.school_rounded;
  static const IconData paketData  = Icons.signal_cellular_alt_rounded;
  static const IconData voucher    = Icons.local_activity_rounded;
  static const IconData donasi     = Icons.volunteer_activism_rounded;
  static const IconData more       = Icons.grid_view_rounded;
  static const IconData close      = Icons.close_rounded;
  static const IconData search     = Icons.search_rounded;
  static const IconData fingerprint= Icons.fingerprint_rounded;
  static const IconData key        = Icons.key_rounded;
  static const IconData xcircle    = Icons.cancel_rounded;
  static const IconData info       = Icons.info_rounded;
  static const IconData qris       = Icons.qr_code_scanner_rounded;
  static const IconData store      = Icons.storefront_rounded;
  static const IconData link       = Icons.link_rounded;
  static const IconData clock      = Icons.access_time_rounded;
  static const IconData refresh    = Icons.refresh_rounded;
  static const IconData settings   = Icons.settings_rounded;
  static const IconData logout     = Icons.logout_rounded;
  static const IconData star       = Icons.star_rounded;
  static const IconData splitBill  = Icons.receipt_long_rounded;
  static const IconData card       = Icons.credit_card_rounded;
  static const IconData food       = Icons.restaurant_rounded;
  static const IconData smartphone = Icons.smartphone_rounded;
}
