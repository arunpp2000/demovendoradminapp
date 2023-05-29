import 'dart:io';
import 'dart:typed_data';
import 'package:demovendoradminapp/navbar/orders/pdfApi.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../model/invoice.dart';
import '../../widgets/util.dart';

var image;
var sign;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class B2cPdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    // image = await imageFromAssetBundle('assets/images/tara1.png');
    // sign = await imageFromAssetBundle('assets/images/SIGN.png');

    // final doc = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    // doc.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.roll80,
    //     build: (pw.Context context) {
    //
    //       return pw.ListView(
    //
    //         children: [
    //           buildHeader(invoice),
    //           SizedBox(height: 1 * PdfPageFormat.cm),
    //           // buildTitle(invoice),
    //           // buildInvoice(invoice),
    //           Divider(),
    //           buildTotal(invoice),
    //         ],
    //       );// Center
    //     }));
    pdf.addPage(MultiPage(
      build: (context) => [
        pw.Image(image,width: 140,height: 140,fit: BoxFit.contain),

        buildHeader(invoice),
        pw.SizedBox(height: 10),
        buildInvoice(invoice),
        Container(height: 1, color: PdfColors.grey400),
        Container(height: 5, color: PdfColors.white),
        buildTotal(invoice),
        pw.SizedBox(height: 15),

        Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,


                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(

                            'Amount in words',style: TextStyle(
                          fontSize: 9,
                        )
                        ),
                        Text(

                            '${invoice.amount?.toUpperCase()}'+'ONLY',style: TextStyle(
                          fontSize: 9,
                        )
                        ),

                      ]),
                  pw.SizedBox(height: 15),
                  Text(

                      'For Thara Online Store',style: TextStyle(
                    fontSize: 9,
                  )
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        pw.Image(sign,height: 130,fit: BoxFit.contain),
                      ]),
                  Text(

                      '  Authorised Signatory',style: TextStyle(
                    fontSize: 9,
                  )
                  ),
                  pw.SizedBox(height: 10),


                  Row(
                      children: [
                        Text(

                            'Whether tax is payable under reverse charge',style: TextStyle(
                          fontSize: 8,
                        )
                        ),
                      ]
                  ),
                  pw.SizedBox(height: 10),

                  Row(
                      children: [
                        Text(

                            'Customers desirous of availing input GST credit are requested to create a Business account and purchase on Tharacart from Business \nEligible offers',style: TextStyle(
                          fontSize: 8,
                        )
                        ),
                      ]
                  ),
                  pw.SizedBox(height: 5),
                  Row(
                      children: [
                        Text(

                            'Please note that this invoice is not a demand for payment.',style: TextStyle(
                          fontSize: 8,
                        )
                        ),
                      ]
                  ),
                  pw.SizedBox(height: 30),

                ]
            )
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(

                  'Thank you for shopping with us !',style: TextStyle(
                fontSize: 9,
              )
              ),
            ]
        ),


      ],
    ));

    print('aaaaaaaaaaaaaaaaaaaaaa');
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdf.save());
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String documentPath = documentDirectory.path;
    // File file = File("$documentPath/TCE-${invoice.invoiceNo}.pdf");
    // file.writeAsBytesSync(await pdf.save());
    return PdfApi.saveB2CDocument(name: 'TCE-${invoice.invoiceNo}.pdf', pdf: pdf);

  }
  static Widget buildHeader(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,

    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // buildSupplierAddress(invoice.supplier),

          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[



                Text('Tax Invoice/Bill of Supply',style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal )),
                pw.SizedBox(height: 8),
                Text('Sold By :',style: TextStyle(fontSize: 8.5 ,fontWeight: FontWeight.bold)),
                Text('Thara Online Store',style: TextStyle(fontSize: 8.5 )),
                Text('11/321, Thara Apartments,',style: TextStyle(fontSize: 8.5 )),
                Text('Hospital Road, Perinthalmanna,',style: TextStyle(fontSize: 8.5 )),
                Text('Malappuram, Kerala, 679322 -IN',style: TextStyle(fontSize: 8.5 )),
                pw.SizedBox(height: 8),
                Text('GSTIN : 32JDVPS7635J1ZK',style: TextStyle(fontSize: 8.5 )),
                Text('PAN Number : JDVPS7635J',style: TextStyle(fontSize: 8.5 )),
                pw.SizedBox(height: 8),
                Text('Order Id : ${invoice.orderId}',style: TextStyle(fontSize: 8.5 )),
                Text('Order Date : ${dateTimeFormat('d-MM-y', invoice.orderDate!.toDate())}',
                    style: TextStyle(fontSize: 8.5 )),
                pw.SizedBox(height: 8),
                invoice.method=='Cash On Delivery'?
                Text('Payment Method : ${invoice.method}  ( 33 Inclusive of Tax )',style: TextStyle(fontSize: 8.5 )):
                Text('Payment Method : ${invoice.method}',style: TextStyle(fontSize: 8.5 )),

              ]),
          pw.SizedBox(width: 15),

          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[

                Text('Billing Address ',style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold )),
                Text(invoice.shippingAddress!.single.name??'',style: TextStyle(fontSize: 8.5 )),
                invoice.shippingAddress!.single.address!.length<30?
                Text(invoice.shippingAddress!.single.address.toString(),style: TextStyle(fontSize: 8.5 ))
                    :

                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(invoice.shippingAddress!.single.address!.substring(0,invoice.shippingAddress!.single.address!.length~/2),style: TextStyle(fontSize: 8.5 )),
                      Text(invoice.shippingAddress!.single.address!.substring(invoice.shippingAddress!.single.address!.length~/2,invoice.shippingAddress!.single.address!.length-1),style: TextStyle(fontSize: 8.5 )),
                    ]),



                // invoice.shippingAddress.single.area.length<30?
                Text(invoice.shippingAddress?.single.area??'',style: TextStyle(fontSize: 8.5 )),
                // :

                // Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Text(invoice.shippingAddress.single.area.substring(0,(invoice.shippingAddress.single.area.length/2).toInt()),style: TextStyle(fontSize: 8.5 )),
                //       Text(invoice.shippingAddress.single.area.substring((invoice.shippingAddress.single.area.length/2).toInt(),invoice.shippingAddress.single.area.length-1),style: TextStyle(fontSize: 8.5 )),
                //     ]),
                Text('GST : ${invoice.shippingAddress!.single.gst}',style: TextStyle(fontSize: 8.5 )),
                Text(invoice.shippingAddress!.single.pincode??'',style: TextStyle(fontSize: 8.5 )),
                Text('Mobile : '+invoice.shippingAddress!.single.mobileNumber.toString(),style: TextStyle(fontSize: 8.5 )),
                pw.SizedBox(height: 8),

                Text('Shipping Address ',style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold )),

                Text(invoice.shippingAddress!.single.name.toString(),style: TextStyle(fontSize: 8.5 )),
                invoice.shippingAddress!.single.address!.length<30?
                Text(invoice.shippingAddress!.single.address??"",style: TextStyle(fontSize: 8.5 ))
                    :

                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(invoice.shippingAddress!.single.address!.substring(0,invoice.shippingAddress!.single.address!.length~/2),style: TextStyle(fontSize: 8.5 )),
                      Text(invoice.shippingAddress!.single.address!.substring(invoice.shippingAddress!.single.address!.length~/2,invoice.shippingAddress!.single.address!.length-1),style: TextStyle(fontSize: 8.5 )),
                    ]),
                // invoice.shippingAddress.single.area.length<30?
                Text(invoice.shippingAddress!.single.area??"",style: TextStyle(fontSize: 8.5 )),
                //     :
                //
                // Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Text(invoice.shippingAddress.single.area.substring(0,(invoice.shippingAddress.single.area.length/2).toInt()),style: TextStyle(fontSize: 8.5 )),
                //       Text(invoice.shippingAddress.single.area.substring((invoice.shippingAddress.single.area.length/2).toInt(),invoice.shippingAddress.single.area.length-1),style: TextStyle(fontSize: 8.5 )),
                //     ]),
                Text('GST : ${invoice.shippingAddress!.single.gst??0}',style: TextStyle(fontSize: 8.5 )),
                Text(invoice.shippingAddress!.single.pincode.toString(),style: TextStyle(fontSize: 8.5 )),
                Text('Mobile : '+invoice.shippingAddress!.single.mobileNumber.toString(),style: TextStyle(fontSize: 8.5 )),
                pw.SizedBox(height: 8),
                Text('Place of Supply : Kerala',style: TextStyle(fontSize: 8.5 )),
                Text('Place of Delivery : '+invoice.shippingAddress!.single.city.toString()+','+invoice.shippingAddress!.single.state.toString(),style: TextStyle(fontSize: 8.5 )),
                Text('ShipRocket Id : ${invoice.shipRocketId}',style: TextStyle(fontSize: 8.5 )),
                Text('Invoice No. TCE-${invoice.invoiceNo.toString()}',style: TextStyle(fontSize: 8.5 )),
                Text('Invoice Date : ${dateTimeFormat('d-MM-y', invoice.invoiceNoDate!.toDate())}',style: TextStyle(fontSize: 8.5)),
                Text('Invoice Date : ${dateTimeFormat('d-MM-y', invoice.invoiceNoDate!.toDate())}',style: TextStyle(fontSize: 8.5)),
                Text('Shipping Method : ${invoice.method}',style: TextStyle(fontSize: 8.5 )),


                // buildInvoiceInfo(invoice.info),
                // Text('Table No : ${invoice.table.toString()}',style: TextStyle(
                //   fontSize: 10
                // )),
              ]),
        ],
      ),
      // SizedBox(height: 1 * PdfPageFormat.cm),

    ],
  );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Pos.',
      'Product',
      'Qty',
      'Unit Price ',
      'Taxable',
      'GST',
      'CGST',
      'SGST',
      'IGST',
      'Price',
      'Total',
    ];
    int aa=0;
    final data = invoice.salesItems!.map((customer) {
      aa++;
      final total = customer.total;
      print(total);
      String? name='';
      String name1='';
      double length=customer.description!.length/2;

      print(customer.description!.length);

      if(customer.description!.length>50){
        name=customer.description!.substring(0,50);
        name1=customer.description!.substring(50,customer.description!.length);

      }else{
        name=customer.description;

      }

      // name1=customer.description.substring(length.toInt(),customer.description.length);

      return [
        aa.toString(),
        '$name \n$name1',
        '${customer.quantity!.toInt()}',
        '${customer.unitPrice!.toStringAsFixed(2)}',
        '${customer.tax!.toStringAsFixed(2)}',
        '${customer.gst!.toStringAsFixed(2)}',
        invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA'?'${(customer.gst!/2).toStringAsFixed(2)}':'',
        invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA'?'${(customer.gst!/2).toStringAsFixed(2)}':'',
        invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA'?'':'${customer.gst!.toStringAsFixed(2)}',
        '${customer.price!.toStringAsFixed(2)}',
        '${total!.toStringAsFixed(2)}',
      ];
    }
    ).toList();

    return Table.fromTextArray(
      headers: headers,

      data: data,


      border: null,


      headerStyle: TextStyle(fontSize:6,fontWeight: FontWeight.bold),

      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellStyle: TextStyle(fontSize: 7,),

      cellHeight: 20,

      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.topLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.centerRight,

      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    double gst =0.00;
    double tax =0.00;
    double total=0.00;
    invoice.salesItems
        ?.map((item) {
      tax+=item.tax!;
      total+=item.total!;
      gst+=item.gst!;
    }).toList();




    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          // Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                invoice.shipping==0?
                buildText(
                  title: 'Shipping ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value: 'Free Shipping',
                  unite: true,
                ):    buildText(
                  title: 'Shipping ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value: invoice.shipping.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Discount ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value: invoice.discount!.toStringAsFixed(2),
                  unite: true,
                ),buildText(
                  title: 'SGST ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value: (invoice.method=='Cash On Delivery'&&invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA')?invoice!.gst!.toStringAsFixed(2):'',
                  unite: true,
                ),
                buildText(
                  title: 'CGST ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value:((invoice.method=='Cash On Delivery'||invoice.method=='RAZORPAY')&&invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA')? invoice.gst!.toStringAsFixed(2):'',
                  unite: true,
                ),
                buildText(
                  title: 'IGST ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value:(invoice.method=='Cash On Delivery'&&invoice.shippingAddress!.single.state!.toUpperCase()=='KERALA')?'':(invoice.gst!*2).toStringAsFixed(2),
                  unite: true,
                ),


                buildText(
                  title: 'Total excl GST ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                  ),
                  value: invoice.total?.toStringAsFixed(2),
                  unite: true,
                ),

                Divider(),
                buildText(
                  title: 'Total : ',
                  titleStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '${invoice.price?.toStringAsFixed(2)!}(includes ${invoice.gst?.toStringAsFixed(2)})',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // static Widget buildFooter(Invoice invoice) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   children: [
  //     Divider(),
  //     SizedBox(height: 2 * PdfPageFormat.mm),
  //     buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //     SizedBox(height: 1 * PdfPageFormat.mm),
  //     // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //   ],
  // );
  //
  // static buildSimpleText({
  //    String title,
  //    String value,
  // }) {
  //   final style = TextStyle(fontWeight: FontWeight.bold);
  //
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //     children: [
  //       Text(title, style: style),
  //       SizedBox(width: 2 * PdfPageFormat.mm),
  //       Text(value),
  //     ],
  //   );
  // }
  //
  static buildText({
    String? title,
    String? value,
    double width = double.infinity,
    TextStyle?  titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold, );

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title!, style: style)),
          Text(value!, style: unite ? style : null),
        ],
      ),
    );
  }
}