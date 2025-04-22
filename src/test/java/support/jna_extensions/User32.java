package support.jna_extensions;

import com.sun.jna.Native;
import com.sun.jna.platform.win32.WinDef.HWND;
import com.sun.jna.win32.StdCallLibrary;
import com.sun.jna.win32.W32APIOptions;

public interface User32 extends StdCallLibrary {
    int WM_GETTEXT = 0x000D;
    int WM_GETTEXTLENGTH = 0x000E;

    User32 instance = Native.load("user32", User32.class, W32APIOptions.DEFAULT_OPTIONS);

    HWND FindWindowEx(HWND hwndParent, HWND hwndChildAfter, String lpazClass, String lpazWindow);

    int SendMessage(HWND hWnd, int msg, int wParam, char[] lParam);
}
