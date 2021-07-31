package cloud.lianmi.app;

import android.annotation.TargetApi;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import cloud.lianmi.app.runtimepermissions.PermissionsManager;
import cloud.lianmi.app.runtimepermissions.PermissionsResultAction;

/**
 * @author lsihijia
 */
public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    flutterEngine.getPlugins().add(new InstallAPKPlugin(this));
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    requestPermissions();
  }

  @TargetApi(23)
  private void requestPermissions() {
    PermissionsManager.getInstance().requestAllManifestPermissionsIfNecessary(this, new PermissionsResultAction() {
      @Override
      public void onGranted() {
//				Toast.makeText(MainActivity.this, "All permissions have been granted", Toast.LENGTH_SHORT).show();
      }

      @Override
      public void onDenied(String permission) {
        //Toast.makeText(MainActivity.this, "Permission " + permission + " has been denied", Toast.LENGTH_SHORT).show();
      }
    });
  }
}
