import 'package:flutter/material.dart';
import '../utils/logger.dart';

class VerificationViewModel extends ChangeNotifier {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _otpFocusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  bool _isLoading = false;
  String _email = '';
  int _remainingTime = 60;
  bool _canResend = false;

  // Getters
  List<TextEditingController> get otpControllers => _otpControllers;
  List<FocusNode> get otpFocusNodes => _otpFocusNodes;
  bool get isLoading => _isLoading;
  String get email => _email;
  int get remainingTime => _remainingTime;
  bool get canResend => _canResend;

  String get formattedTime {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get canVerify {
    return _otpControllers[0].text.isNotEmpty && !_isLoading;
  }

  String get otpCode {
    return _otpControllers[0].text;
  }

  void setEmail(String email) {
    _email = email;
    Logger.info('VerificationViewModel: Email set for verification');
    notifyListeners();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      // Move to next field
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      _otpFocusNodes[index - 1].requestFocus();
    }
    notifyListeners();
  }

  void onSingleOtpChanged(String value) {
    notifyListeners();
  }

  void clearOtp() {
    Logger.debug('VerificationViewModel: Clearing OTP fields');
    for (var controller in _otpControllers) {
      controller.clear();
    }
    _otpFocusNodes[0].requestFocus();
    notifyListeners();
  }

  Future<void> verifyCode() async {
    if (!canVerify) {
      Logger.warning('VerificationViewModel: Verify code called but conditions not met');
      return;
    }

    Logger.info('VerificationViewModel: Starting verification process');
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual verification logic
      Logger.info('VerificationViewModel: Verification API call successful');

      // For now, just simulate success
      // In real app, navigate to next screen or show success
    } catch (e) {
      // Handle error
      Logger.error('VerificationViewModel: Verification failed', error: e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendCode() async {
    if (!_canResend) {
      Logger.warning('VerificationViewModel: Resend code attempted but not allowed yet');
      return;
    }

    Logger.info('VerificationViewModel: Resending verification code');

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Reset timer
      _remainingTime = 60;
      _canResend = false;
      startTimer();

      Logger.info('VerificationViewModel: Verification code resent successfully');
    } catch (e) {
      Logger.error('VerificationViewModel: Resend code failed', error: e);
    }
  }

  void startTimer() {
    Logger.info('VerificationViewModel: Starting verification timer (60 seconds)');
    _remainingTime = 60;
    _canResend = false;
    notifyListeners();

    // Start countdown timer
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
        return true;
      } else {
        _canResend = true;
        Logger.info('VerificationViewModel: Timer expired, resend now available');
        notifyListeners();
        return false;
      }
    });
  }

  @override
  void dispose() {
    Logger.debug('VerificationViewModel: Disposing resources');
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
