import 'package:flutter/material.dart';
import 'package:givt_app/core/enums/enums.dart';
import 'package:givt_app/features/auth/widgets/terms_and_conditions_dialog.dart';
import 'package:givt_app/l10n/l10n.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    this.email = '',
  });
  final String email;
  static MaterialPageRoute<dynamic> route({String email = ''}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => SignUpPage(
        email: email,
      ),
    );
  }

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  bool _acceptPolicy = false;
  bool isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Image.asset(
          'assets/images/logo.png',
          height: size.height * 0.04,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark_outlined),
            onPressed: () {
              ///todo add faq here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).firstName,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).lastName,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: widget.email.isNotEmpty,
                controller: _emailController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.contains('@') == false) {
                    return AppLocalizations.of(context).invalidEmail;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).email,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  if (value.length < 7) {
                    return '';
                  }
                  if (value.contains(RegExp('[0-9]')) == false) {
                    return '';
                  }
                  if (value.contains(RegExp('[A-Z]')) == false) {
                    return '';
                  }

                  return null;
                },
                obscureText: _obscureText,
                textInputAction: TextInputAction.next,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                locals.passwordRule,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _buildAcceptPolicy(locals),
              ElevatedButton(
                onPressed: _acceptPolicy == true
                    ? () {
                        // Register user logic
                      }
                    : null,
                child: Text(
                  locals.next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptPolicy(AppLocalizations locals) {
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        builder: (BuildContext context) => const TermsAndConditionsDialog(
          typeOfTerms: TypeOfTerms.privacyPolicy,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _acceptPolicy,
            onChanged: (value) {
              setState(() {
                _acceptPolicy = value!;
              });
            },
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: locals.acceptPolicy,
                ),
                const WidgetSpan(
                  child: Icon(Icons.info_rounded, size: 16),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
