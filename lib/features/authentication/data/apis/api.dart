class EndPoints {
  EndPoints._internal();

  /// BASE
  static const String baseUrl =
      'https://life-makers.digifly-eg.com/api/';
  /// HANY

  static const String allSeasonalCampaigns = 'campaign/seasonal';
  static const String allNonSeasonalCampaigns = 'campaign/non-seasonal';
  static const String getAllCandidates = 'Voters';
  static const String getUserVotes = 'my_vote';
   static const String getEmergenyCampaigns = 'campaign/current-non-seasonal';
  static const String joinCampaign = 'campaign/user-join';
  static const String getAllCampaigns = 'campaign/all-campaigns';
  static const String campaignSuggestion = 'campaign/user-suggestion';
  static const String campaignComplaign = 'campaign/user-complaint';
  static const String leaveCampaign = 'campaign/user-leave';
  static const String editProfile = 'user-edit';
  static const String homeCalender = 'home-calender';

  /// YOUSEF
  static const String loginApi =
      'https://life-makers.digifly-eg.com/api/login';
  static const String registerApi =
      'https://life-makers.digifly-eg.com/api/register';
  static const String resendOtpCodeApi =
      'https://life-makers.digifly-eg.com/api/resend-code';
  static const String submitOtpCodeAPi =
      'https://life-makers.digifly-eg.com/api/submit-code';
  static const String resetPasswordApi =
      'https://life-makers.digifly-eg.com/api/reset-change-password';
  static const String changePasswordAfterLoginApi =
      'https://life-makers.digifly-eg.com/api/change-password';
  static const String sendOtpCode =
      'https://life-makers.digifly-eg.com/api/new-send-code';
  static const String submitOtpCode =
      'https://life-makers.digifly-eg.com/api/new-submit-code';
  static const String deleteAccount =
      'https://life-makers.digifly-eg.com/api/user-delete';
  static const String sendResetPasswordOtpCode =
      'https://life-makers.digifly-eg.com/api/reset-password';
  static const String SubmitResetPasswordOtpCode =
      'https://life-makers.digifly-eg.com/api/submit-code';
  static const String changePasswordFromReset =
      'https://life-makers.digifly-eg.com/api/reset-change-password';
  static const String VolunteerTrainingProgram =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities/program';
  static const String oneDayActivity =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities/activity';
  static const String remoteTasks =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities/tasks';
  static const String suggestionsVolunteers =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities/user-suggestion';
  static const String userJoinVolunteer =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities/user-join';
  static const String userLeftVolunteer =
      'https://life-makers.digifly-eg.com/api/volunteer-opportunities-leave';
  static const String cityApi =
      'https://life-makers.digifly-eg.com/api/cities';
  static const String changePasswordAfterLogin =
      'https://life-makers.digifly-eg.com/api/change-password';
}
