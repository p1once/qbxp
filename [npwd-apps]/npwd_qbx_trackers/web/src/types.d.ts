export {};

declare global {
  function GetParentResourceName(): string | undefined;
  interface Window {
    invokeNative?: unknown;
  }
}
