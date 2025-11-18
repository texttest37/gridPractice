import 'dart:async';
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
  Timer? _timer;
  bool _isDisposed = false;

  // Safe notifyListeners that checks if disposed
  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

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

  Future<bool> verifyCode() async {
    if (!canVerify) {
      Logger.warning('VerificationViewModel: Verify code called but conditions not met');
      return false;
    }

    Logger.info('VerificationViewModel: Starting verification process');
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual verification logic
      Logger.info('VerificationViewModel: Verification API call successful');

      _isLoading = false;
      notifyListeners();
      return true; // Verification successful
    } catch (e) {
      // Handle error
      Logger.error('VerificationViewModel: Verification failed', error: e);
      _isLoading = false;
      notifyListeners();
      return false; // Verification failed
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
    
    // Cancel any existing timer
    _timer?.cancel();
    
    _remainingTime = 60;
    _canResend = false;
    
    // Use a safer approach with mounted check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        notifyListeners();
      }
    });

    // Start countdown timer with additional safety checks
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        if (_isDisposed) {
          timer.cancel();
          return;
        }
        
        if (_remainingTime > 0) {
          _remainingTime--;
          _safeNotifyListeners();
        } else {
          _canResend = true;
          Logger.info('VerificationViewModel: Timer expired, resend now available');
          timer.cancel();
          _safeNotifyListeners();
        }
      } catch (e) {
        Logger.error('VerificationViewModel: Timer error', error: e);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    Logger.debug('VerificationViewModel: Disposing resources');
    
    // Mark as disposed to prevent further notifyListeners calls
    _isDisposed = true;
    
    // Cancel the timer to prevent calling notifyListeners after disposal
    _timer?.cancel();
    
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
