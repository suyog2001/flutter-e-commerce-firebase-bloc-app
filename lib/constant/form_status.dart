/// Abstract Class FormSubmissionStatus
///
///  FormSubmissionStatus is use to check the current State of the form when running
abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

/// InitialFormStatus state when the form is just opened or is type the fields
class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

/// FormSubmmitingStatus state when the user clicks the button and applicaiton is trying to communicate with server
class FormSubmmitingStatus extends FormSubmissionStatus {}

/// FormSubmmisionSuccessStatus state when the application is successfully submited
class FormSubmmisionSuccessStatus extends FormSubmissionStatus {}

/// FormSubmissionFailedStatus state when the form has error.
///
/// It has a property named [errorMessage] which contents the error
class FormSubmissionFailedStatus extends FormSubmissionStatus {
  final String errorMessage;
  const FormSubmissionFailedStatus({required this.errorMessage});
}
