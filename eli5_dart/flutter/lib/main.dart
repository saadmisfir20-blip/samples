import { useRef, useState } from 'react';
import {
  ActivityIndicator,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { WebView } from 'react-native-webview';
import { WifiOff } from 'lucide-react-native';
import { COLORS, FONTS, SPACING } from '@/constants/theme';

const SITE_URL = 'https://ibn-masfar-building-6lax.bolt.host/';

export default function WebViewScreen() {
  const webviewRef = useRef<WebView>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  const handleReload = () => {
    setError(false);
    setLoading(true);
    webviewRef.current?.reload();
  };

  if (error) {
    return (
      <View style={styles.errorContainer}>
        <WifiOff color={COLORS.neutral[400]} size={64} strokeWidth={1.5} />
        <Text style={styles.errorTitle}>تعذر تحميل الموقع</Text>
        <Text style={styles.errorMessage}>
          تحقق من اتصالك بالإنترنت وحاول مرة أخرى
        </Text>
        <Pressable style={styles.retryButton} onPress={handleReload}>
          <Text style={styles.retryText}>إعادة المحاولة</Text>
        </Pressable>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <WebView
        ref={webviewRef}
        source={{ uri: SITE_URL }}
        style={styles.webview}
        onLoadStart={() => setLoading(true)}
        onLoadEnd={() => setLoading(false)}
        onError={() => {
          setError(true);
          setLoading(false);
        }}
        javaScriptEnabled
        domStorageEnabled
      />
      {loading && (
        <View style={styles.loadingOverlay} pointerEvents="none">
          <ActivityIndicator size="large" color={COLORS.primary[600]} />
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.neutral[0],
  },
  webview: {
    flex: 1,
  },
  loadingOverlay: {
    ...StyleSheet.absoluteFillObject,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: COLORS.neutral[0],
  },
  errorContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: SPACING.xl,
    backgroundColor: COLORS.neutral[50],
  },
  errorTitle: {
    fontFamily: FONTS.bold,
    fontSize: 20,
    color: COLORS.neutral[800],
    marginTop: SPACING.lg,
  },
  errorMessage: {
    fontFamily: FONTS.regular,
    fontSize: 15,
    color: COLORS.neutral[500],
    textAlign: 'center',
    marginTop: SPACING.sm,
  },
  retryButton: {
    marginTop: SPACING.xl,
    paddingHorizontal: SPACING.xl,
    paddingVertical: SPACING.md,
    backgroundColor: COLORS.primary[600],
    borderRadius: 999,
  },
  retryText: {
    fontFamily: FONTS.bold,
    fontSize: 15,
    color: COLORS.neutral[0],
  },
});
