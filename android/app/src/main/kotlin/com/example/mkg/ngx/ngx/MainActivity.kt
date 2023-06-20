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
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    //ui style components
    private val title_font_size = 42f;


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
            } else {
                result.notImplemented()
            }
        }

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
        val tvStatus: TextView? = null

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
