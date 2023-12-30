abstract class VolunteerState {}

class VolunteerInitial extends VolunteerState {}

class VolunteerProgramLoading extends VolunteerState {}

class VolunteerProgramSuccess extends VolunteerState {}

class VolunteerProgramFailure extends VolunteerState {
  final String error;

  VolunteerProgramFailure(this.error);
}

class VolunteerOneDayActivityLoading extends VolunteerState {}

class VolunteerOneDayActivitySuccess extends VolunteerState {}

class VolunteerOneDayActivityFailure extends VolunteerState {
  final String error;

  VolunteerOneDayActivityFailure(this.error);
}

class UserJoinedProgramLoading extends VolunteerState {}

class UserJoinedProgramSuccess extends VolunteerState {}

class UserJoinedProgramFailure extends VolunteerState {
  final String error;

 UserJoinedProgramFailure(this.error);
}

class UserLeftProgramLoading extends VolunteerState {}

class UserLeftProgramSuccess extends VolunteerState {}

class UserLeftProgramFailure extends VolunteerState {
  final String error;

  UserLeftProgramFailure(this.error);
}

class JoinedProgramLoading extends VolunteerState {}

class JoinedProgramSuccess extends VolunteerState {}

class JoinedProgramFailure extends VolunteerState {
  final String error;

  JoinedProgramFailure(this.error);
}

class JoinedCampaignsSuccess extends VolunteerState {}

class JoinedCampaignsLoading extends VolunteerState {}

class JoinedCampaignsFailure extends VolunteerState {
  final String error;

  JoinedCampaignsFailure(this.error);
}

