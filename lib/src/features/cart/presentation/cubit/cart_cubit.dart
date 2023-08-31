import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:works_app/src/core/cubit/generic_state.dart';
import 'package:works_app/src/features/products/domain/entities/product_entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:works_ds/works_ds.dart';
import 'package:path_provider/path_provider.dart';

class CartCubit extends Cubit<GenericState> {
  CartCubit() : super(InitState());

  List<ProductEntity?> listProductEntity = [];

  Future<void> createPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text('receipt'.i18n()),
              ),
              pw.SizedBox(height: 30),
              pw.ListView.builder(
                itemBuilder: (context, index) {
                  return pw.Padding(
                    padding: pw.EdgeInsets.symmetric(
                      horizontal: CustomSizes.sizeXXS,
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          listProductEntity[index]!.name ?? '',
                          style: pw.TextStyle(
                            fontSize: CustomSizes.sizeL,
                          ),
                        ),
                        pw.SizedBox(
                          height: 8,
                        ),
                        pw.Text(
                          '${'price'.i18n()}: '
                          '${listProductEntity[index]!.price!}',
                          style: pw.TextStyle(
                            fontSize: CustomSizes.sizeM,
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: listProductEntity.length,
              ),
            ],
          ); // Center
        },
      ),
    );
    final Directory appDocumentsDir =
        (await getApplicationDocumentsDirectory());
    String path =
        '${appDocumentsDir.path}/pdfExample${DateTime.now().toIso8601String()}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save()).whenComplete(
      () {
        clear();
        Modular.to.pushReplacementNamed('product');
      },
    );
  }

  void add(ProductEntity productEntity) {
    listProductEntity.add(productEntity);
    emit(SuccessState());
    emit(InitState());
  }

  void remove(int index) {
    listProductEntity.removeAt(index);
    emit(SuccessState());
    emit(InitState());
  }

  void clear() {
    listProductEntity = [];
  }
}
