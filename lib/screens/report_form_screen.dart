import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState {
  idle,
  loading,
  success,
  empty,
  error,
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  ReportUiState _state = ReportUiState.idle;

  bool _simulateError = false;

  final List<String> _categories = [
    'Inventory Issue',
    'Damaged Product',
    'Expired Product',
    'Stock Shortage',
    'Other',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _state = ReportUiState.loading;
    });

    // Simulated response because the backend is not connected yet.
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _state = _simulateError
          ? ReportUiState.error
          : ReportUiState.success;
    });
  }

  void _showEmptyState() {
    setState(() {
      _state = ReportUiState.empty;
    });
  }

  void _resetForm() {
    setState(() {
      _selectedCategory = null;
      _descriptionController.clear();
      _state = ReportUiState.idle;
      _simulateError = false;
    });
  }

  Widget _buildStateMessage({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentState() {
    switch (_state) {
      case ReportUiState.loading:
        return _buildStateMessage(
          icon: Icons.hourglass_top,
          color: const Color(0xFF995F2F),
          title: 'Submitting Report...',
          message:
              'Please wait. This is a simulated submission because the backend is not connected.',
        );

      case ReportUiState.success:
        return _buildStateMessage(
          icon: Icons.check_circle_outline,
          color: Colors.green,
          title: 'Report Submitted Successfully!',
          message:
              'This is a simulated success response. The report has not been saved to a database.',
        );

      case ReportUiState.empty:
        return _buildStateMessage(
          icon: Icons.inbox_outlined,
          color: const Color(0xFF978F66),
          title: 'No Reports Available',
          message:
              'There are no report records to display. Backend integration is not available yet.',
        );

      case ReportUiState.error:
        return Column(
          children: [
            _buildStateMessage(
              icon: Icons.error_outline,
              color: Colors.red,
              title: 'Submission Failed',
              message:
                  'This is a simulated error. Please try submitting the report again.',
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Try Again',
              icon: Icons.refresh,
              onPressed: _submitReport,
            ),
          ],
        );

      case ReportUiState.idle:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _state == ReportUiState.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Report'),
        backgroundColor: const Color(0xFF622B14),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Card(
              color: const Color(0xFFFFFCF5),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.assignment_outlined,
                      size: 42,
                      color: Color(0xFF622B14),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Submit an Inventory Report',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF622B14),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Report damaged products, expired items, or other inventory issues.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (_state == ReportUiState.idle) ...[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Report Category',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF622B14),
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              decoration: InputDecoration(
                                hintText: 'Select a category',
                                prefixIcon: const Icon(
                                  Icons.category_outlined,
                                  color: Color(0xFF995F2F),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: _categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a category.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            AppTextField(
                              label: 'Report Description',
                              hint: 'Describe the inventory issue',
                              controller: _descriptionController,
                              prefixIcon: Icons.description_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a description.';
                                }
                                if (value.trim().length < 5) {
                                  return 'Enter at least 5 characters.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            AppButton(
                              text: 'Submit Report',
                              icon: Icons.send,
                              isLoading: isLoading,
                              onPressed: _submitReport,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text(
                        'Testing UI States',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF622B14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Use these options to demonstrate the required UI states. They do not connect to a backend.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: _showEmptyState,
                        icon: const Icon(Icons.inbox_outlined),
                        label: const Text('Show Empty State'),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Simulate submission error'),
                        subtitle: const Text(
                          'Turn on to display the Error state after submitting.',
                        ),
                        activeColor: const Color(0xFF622B14),
                        value: _simulateError,
                        onChanged: (value) {
                          setState(() {
                            _simulateError = value;
                          });
                        },
                      ),
                    ],

                    if (_state != ReportUiState.idle) ...[
                      _buildCurrentState(),
                      const SizedBox(height: 16),
                      if (_state != ReportUiState.loading)
                        AppButton(
                          text: 'Back to Report Form',
                          icon: Icons.arrow_back,
                          onPressed: _resetForm,
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
