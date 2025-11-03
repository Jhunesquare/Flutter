import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/universidad.dart';

class UniversidadFormScreen extends StatefulWidget {
  const UniversidadFormScreen({super.key});

  @override
  State<UniversidadFormScreen> createState() => _UniversidadFormScreenState();
}

class _UniversidadFormScreenState extends State<UniversidadFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      final values = _formKey.currentState!.value;
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);

      try {
        final universidad = Universidad(
          nit: values['nit'],
          nombre: values['nombre'],
          direccion: values['direccion'],
          telefono: values['telefono'],
          paginaWeb: values['pagina_web'],
        );

        await firebaseService.crearUniversidad(universidad);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Universidad creada exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Universidad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'nit',
                decoration: const InputDecoration(
                  labelText: 'NIT',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Campo requerido'),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'nombre',
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Campo requerido'),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'direccion',
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 2,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Campo requerido'),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'telefono',
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Campo requerido'),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'pagina_web',
                decoration: const InputDecoration(
                  labelText: 'Página Web',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                  hintText: 'https://ejemplo.com',
                ),
                keyboardType: TextInputType.url,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Campo requerido'),
                  FormBuilderValidators.url(errorText: 'URL inválida'),
                ]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Guardar Universidad', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
