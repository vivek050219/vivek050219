package support.jna_extensions;

import com.sun.jna.platform.win32.WinDef.HWND;

public class WindowHelper {
    /**
     * FindWindowEx will find the *first* of the given control type
     * this allows to find an arbitrary control of the type identified by its index
     * adapted from C# code at https://stackoverflow.com/a/5685715/2136840
     *
     * @param hWndParent window containing control to lookup
     * @param lpazClass  control type to lookup
     * @param index      index number of control in window
     * @return pointer to control
     */
    public static HWND FindWindowByIndex(HWND hWndParent, String lpazClass, int index) {
        if (index == 0) {
            return hWndParent;
        } else {
            int ct = 0;
            HWND result = null;
            do {
                result = User32.instance.FindWindowEx(hWndParent, result, lpazClass, null);
                if (result != null)
                    ++ct;
            } while (ct < index && result != null);
            return result;
        }
    }
}
