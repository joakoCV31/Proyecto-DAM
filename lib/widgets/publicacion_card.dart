import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descuidau/constants.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PublicacionCard extends StatelessWidget {
  const PublicacionCard({
    super.key,
    required this.data,
    required this.onTap,
  });

  final Map<String, dynamic> data;
  final VoidCallback onTap;

  Uint8List? _obtenerBytesFoto(dynamic valorFoto) {
    if (valorFoto is Blob) return valorFoto.bytes;
    if (valorFoto is Uint8List) return valorFoto;
    if (valorFoto is List) {
      return Uint8List.fromList(valorFoto.cast<int>());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String titulo = data['titulo'] ?? 'Sin título';
    final String tipo = data['tipo'] ?? 'Perdido';
    final String categoria = data['categoria'] ?? 'Otros';
    final String estado = data['estado'] ?? 'Vigente';
    final String lugar = data['lugar'] ?? '';
    final Uint8List? fotoBytes = _obtenerBytesFoto(data['foto']);
    final bool esDevuelto = estado == 'Devuelto';
    final bool esPerdido = tipo == 'Perdido';

    final Color tipoColor = esPerdido ? kPerdidoColor : kEncontradoColor;
    final Color tipoBg = esPerdido ? kPerdidoBgColor : kEncontradoBgColor;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      color: Color(0xFFF5F7F6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Opacity(
                  opacity: esDevuelto ? 0.55 : 1.0,
                  child: SizedBox(
                    width: 92,
                    height: 92,
                    child: fotoBytes != null
                        ? Image.memory(
                            fotoBytes,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: 32,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: esDevuelto ? kDevueltoBgColor : tipoBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tipo.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: esDevuelto
                                  ? kDevueltoColor
                                  : tipoColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: esDevuelto
                                ? kDevueltoBgColor
                                : Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: esDevuelto
                                  ? kDevueltoColor
                                  : kAccentColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                esDevuelto
                                    ? Icons.check_circle
                                    : Icons.schedule,
                                size: 12,
                                color: esDevuelto
                                    ? kDevueltoColor
                                    : kAccentColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                estado,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: esDevuelto
                                      ? kDevueltoColor
                                      : kAccentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      titulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: esDevuelto
                            ? kDevueltoColor
                            : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            categoria,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (lugar.isNotEmpty) ...[
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lugar,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}