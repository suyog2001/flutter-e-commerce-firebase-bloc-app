abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmmitingStatus extends FormSubmissionStatus {}

class FormSubmmisionSuccessStatus extends FormSubmissionStatus {}

class FormSubmissionFailedStatus extends FormSubmissionStatus {
  final String errorMessage;
  const FormSubmissionFailedStatus({required this.errorMessage});
}
