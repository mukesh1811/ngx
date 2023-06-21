package com.example.mkg.ngx.ngx


import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Typeface
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.text.Layout
import android.text.TextPaint
import android.widget.TextView
import androidx.annotation.NonNull
import com.ngx.mp200sdk.NGXAshwaPrinter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    //ui style components
    private val title_font_size = 42f
    private val body_font_size = 24f;

    //printer related
    private val CHANNEL = "ngx.print.channel"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "printBalance") {

                val customer_name = call.argument("customer_name") ?: "Mukesh"
                val balance = call.argument("balance") ?: "0"

                val printStatus = printBalance(customer_name, balance)

                //val batteryLevel = getBatteryLevel()

                if (printStatus != -1) {
                    result.success(printStatus)
                } else {
                    result.error("UNAVAILABLE", "Status = $printStatus", null)
                }
            }
            else if (call.method == "printToken")
            { 
                
                val printStatus = printToken(call)

                if (printStatus != -1) {
                    result.success(printStatus)
                } else {
                    result.error("UNAVAILABLE", "Status = $printStatus", null)
                }
            }
            else if (call.method == "printRetail")
            {

                val printStatus = printRetail(call)

                if (printStatus != -1) {
                    result.success(printStatus)
                } else {
                    result.error("UNAVAILABLE", "Status = $printStatus", null)
                }
            }
            else if (call.method == "printReceipt")
            {

                val printStatus = printReceipt(call)

                if (printStatus != -1) {
                    result.success(printStatus)
                } else {
                    result.error("UNAVAILABLE", "Status = $printStatus", null)
                }
            }
            else if (call.method == "printContent")
            {

                val printStatus = printContent(call)

                if (printStatus != -1) {
                    result.success(printStatus)
                } else {
                    result.error("UNAVAILABLE", "Status = $printStatus", null)
                }
            }
            else {
                result.notImplemented()
            }
        }

    }

    private fun printContent(call: MethodCall): Int {

        val reportType = call.argument( "report_type") ?: "dummy_report_content";
        val content_str = call.argument( "print_content") ?: "dummy_report_content";

        val ngxPrinter = NGXAshwaPrinter.getNgxPrinterInstance()
        ngxPrinter.initService(this)

        val tp = TextPaint()
        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = title_font_size

        ngxPrinter.addText("RENUKA SYSTEMS", Layout.Alignment.ALIGN_CENTER, tp)

        tp.textSize = 32f

        ngxPrinter.addText("ITEM REPORT - ${reportType.uppercase()}", Layout.Alignment.ALIGN_CENTER, tp)

        tp.typeface = Typeface.DEFAULT
        tp.textSize = 22f

        ngxPrinter.addText( content_str, Layout.Alignment.ALIGN_NORMAL,tp)

        ngxPrinter.print()

        ngxPrinter.lineFeed(5)

        return 100

    }

    private fun printToken(call: MethodCall): Int {

        val token_no = call.argument( "token_no") ?: "dummy_token_no";
        val date_field = call.argument( "date_field") ?: "dummy_date_field";
        val lot_no = call.argument( "lot_no") ?: "dummy_lot_no";
        val consignor_id = call.argument( "consignor_id") ?: "dummy_consignor_id";
        val item_name = call.argument( "item_name") ?: "dummy_item_name";
        val payment_type = call.argument( "payment_type") ?: "dummy_payment_type";
        val mark = call.argument( "mark") ?: "dummy_mark";
        val units = call.argument( "units") ?: "dummy_units";
        val weight = call.argument( "weight") ?: "dummy_weight";
        val rate = call.argument( "rate") ?: "dummy_rate";
        val c_and_g = call.argument( "c_and_g") ?: "dummy_c_and_g";
        val amount = call.argument( "amount") ?: "dummy_amount";

        val ngxPrinter = NGXAshwaPrinter.getNgxPrinterInstance()
        ngxPrinter.initService(this)

        val tp = TextPaint()
        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = title_font_size

        ngxPrinter.addText("RENUKA SYSTEMS", Layout.Alignment.ALIGN_CENTER, tp)

        val stringBuilder = StringBuilder()

        stringBuilder.append("Token No: $token_no                     $date_field")

        stringBuilder.append("\n")

        stringBuilder.append("---------------------------------------------------")

        stringBuilder.append("\n")

        if(lot_no != "---")
        {
        stringBuilder.append("Lot No:          $lot_no")
        stringBuilder.append("\n")
        stringBuilder.append("\n")
        }

        stringBuilder.append("Consignor Name:  \n$consignor_id")
        stringBuilder.append("\n")
        stringBuilder.append("\n")
        stringBuilder.append("Item Name:       $item_name")
        stringBuilder.append("\n")


        if(payment_type != "--- Cash ---")
        {
        stringBuilder.append("\n")
        stringBuilder.append("Customer Name:   \n$payment_type")
        stringBuilder.append("\n")
        stringBuilder.append("\n")
        }

        stringBuilder.append("---------------------------------------------------")
        stringBuilder.append("\n")

        if(mark != "")
        {
        stringBuilder.append("Mark :                             " + mark)
        stringBuilder.append("\n")
        }

        stringBuilder.append("Units   :                          " + units)
        stringBuilder.append("\n")

        if(weight != "") {
        stringBuilder.append("Weight  :                        " + weight)
        stringBuilder.append("\n")
        }

        stringBuilder.append("Rate    :                          " + rate)
        stringBuilder.append("\n")

        if(c_and_g != "") {
        stringBuilder.append("C and G :                        " + c_and_g)
        stringBuilder.append("\n")
        }

        stringBuilder.append("---------------------------------------------------")
        stringBuilder.append("\n")

        stringBuilder.append("Amount  :                     " + amount)
        stringBuilder.append("\n")
        stringBuilder.append("---------------------------------------------------")



        tp.typeface = Typeface.DEFAULT
        tp.textSize = body_font_size

        ngxPrinter.addText(stringBuilder.toString(), Layout.Alignment.ALIGN_NORMAL,tp)

        ngxPrinter.print()

        ngxPrinter.lineFeed(5)

        return 100

    }

    private fun printRetail(call: MethodCall): Int {

        val retail_no = call.argument( "retail_no") ?: "dummy_retail_no";
        val date_field = call.argument( "date_field") ?: "dummy_date_field";

        val item_name = call.argument( "item_name") ?: "dummy_item_name";
        val payment_type = call.argument( "payment_type") ?: "dummy_payment_type";

        val units = call.argument( "units") ?: "dummy_units";
        val weight = call.argument( "weight") ?: "dummy_weight";
        val rate = call.argument( "rate") ?: "dummy_rate";

        val amount = call.argument( "amount") ?: "dummy_amount";

        val ngxPrinter = NGXAshwaPrinter.getNgxPrinterInstance()
        ngxPrinter.initService(this)

        val tp = TextPaint()
        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = title_font_size

        ngxPrinter.addText("RENUKA SYSTEMS", Layout.Alignment.ALIGN_CENTER, tp)

        val stringBuilder = StringBuilder()

        stringBuilder.append("Retail No: $retail_no                     $date_field")

        stringBuilder.append("\n")

        stringBuilder.append("---------------------------------------------------")

        stringBuilder.append("\n")

        stringBuilder.append("Item Name:       $item_name")
        stringBuilder.append("\n")


        if(payment_type != "--- Cash ---")
        {
            stringBuilder.append("\n")
            stringBuilder.append("Customer Name:   \n$payment_type")
            stringBuilder.append("\n")
            stringBuilder.append("\n")
        }

        stringBuilder.append("---------------------------------------------------")
        stringBuilder.append("\n")


        if(units != "")
        {
        stringBuilder.append("Units :                          " + units)
        stringBuilder.append("\n")
        }

        if(weight != "")
        {
        stringBuilder.append("Weight :                       " + weight)
        stringBuilder.append("\n")
        }

        stringBuilder.append("Rate :                           " + rate)
        stringBuilder.append("\n")


        stringBuilder.append("---------------------------------------------------")
        stringBuilder.append("\n")

        stringBuilder.append("Amount :                     " + amount)
        stringBuilder.append("\n")
        stringBuilder.append("---------------------------------------------------")



        tp.typeface = Typeface.DEFAULT
        tp.textSize = body_font_size

        ngxPrinter.addText(stringBuilder.toString(), Layout.Alignment.ALIGN_NORMAL,tp)

        ngxPrinter.print()

        ngxPrinter.lineFeed(5)

        return 100

    }

    private fun printReceipt(call: MethodCall): Int {

        val receipt_no = call.argument( "receipt_no") ?: "dummy_receipt_no";
        val date_field = call.argument( "date_field") ?: "dummy_date_field";

        val customer_name = call.argument( "customer_name") ?: "dummy_customer_name";

        val balance = call.argument( "balance") ?: "dummy_balance";

        val ngxPrinter = NGXAshwaPrinter.getNgxPrinterInstance()
        ngxPrinter.initService(this)

        val tp = TextPaint()
        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = title_font_size

        ngxPrinter.addText("RENUKA SYSTEMS", Layout.Alignment.ALIGN_CENTER, tp)

        val stringBuilder = StringBuilder()

        stringBuilder.append("Receipt No: $receipt_no                   $date_field")

        stringBuilder.append("\n")

        stringBuilder.append("---------------------------------------------------")

        stringBuilder.append("Customer Name:       \n$customer_name")
        stringBuilder.append("\n")

        stringBuilder.append("\n")

        stringBuilder.append("Balance:       $balance")
        stringBuilder.append("\n")


        tp.typeface = Typeface.DEFAULT
        tp.textSize = body_font_size

        ngxPrinter.addText(stringBuilder.toString(), Layout.Alignment.ALIGN_NORMAL,tp)

        ngxPrinter.print()

        ngxPrinter.lineFeed(5)

        return 100

    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
        }

        return batteryLevel
    }

    private fun printBalance(customer_name: String, balance: String): Int {


        val ngxPrinter = NGXAshwaPrinter.getNgxPrinterInstance()


        val tp = TextPaint()
        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = title_font_size

        ngxPrinter.initService(this)

        ngxPrinter.addText("RENUKA SYSTEMS", Layout.Alignment.ALIGN_CENTER, tp)

        //reset style
        tp.typeface = Typeface.DEFAULT
        tp.textSize = 28f


        val stringBuilder = StringBuilder()

        stringBuilder.append("\n")
        //ngxPrinter.addText("\n")

        stringBuilder.append("Customer Name:\n")
        //ngxPrinter.addText("Customer Name: ", Layout.Alignment.ALIGN_NORMAL, tp)

        stringBuilder.append("$customer_name \n \n")
//        ngxPrinter.addText(customer_name, Layout.Alignment.ALIGN_NORMAL, tp)
//        ngxPrinter.addText("\n")

        stringBuilder.append("Balance:     $balance \n")
        //ngxPrinter.addText("Balance:     $balance", Layout.Alignment.ALIGN_NORMAL, tp)

        // tp.setTypeface(Typeface.create(tf, Typeface.BOLD));
        ngxPrinter.addText(stringBuilder.toString(), Layout.Alignment.ALIGN_NORMAL, tp)

        tp.typeface = Typeface.DEFAULT_BOLD
        tp.textSize = 48f
        ngxPrinter.addText("---------------\n", Layout.Alignment.ALIGN_CENTER, tp)

        ngxPrinter.print()

        ngxPrinter.lineFeed(5)

        return 100
    }

}
