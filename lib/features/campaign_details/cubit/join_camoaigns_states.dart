abstract class JoinCampaignState {}

class InitialState extends JoinCampaignState {}

class LoadingState extends JoinCampaignState {}

class DoneState extends JoinCampaignState {}

class ErrorState extends JoinCampaignState {}

class EmptyState extends JoinCampaignState {}

class DoneJoinCampaignState extends JoinCampaignState {}

class CampaignCheckedInState extends JoinCampaignState {}

class CampaignCheckedOutState extends JoinCampaignState {}

class ProfileImageLoadingState extends JoinCampaignState {}

class ProfileImageSuccessState extends JoinCampaignState {}

class ProfileImageFailureState extends JoinCampaignState {}

class UserInCampaignImageLoadingState extends JoinCampaignState {}

class UserInCampaignImageSuccessState extends JoinCampaignState {}

class UserInCampaignImageFailureState extends JoinCampaignState {}

class ProfileImageUploadLoadingState extends JoinCampaignState {}

class ProfileImageUploadSuccessState extends JoinCampaignState {}

class ProfileImageUploadFailureState extends JoinCampaignState {}

class UserInCampaignImageUploadLoadingState extends JoinCampaignState {}

class UserInCampaignImageUploadSuccessState extends JoinCampaignState {}

class UserInCampaignImageUploadFailureState extends JoinCampaignState {}

class ImagesLoadingState extends JoinCampaignState {}

class ImagesSuccessState extends JoinCampaignState {}

class ImagesFailureState extends JoinCampaignState {}
