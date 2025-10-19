const resourceName = 'npwd_qbx_trackers';

export const isEnvBrowser = () => typeof window !== 'undefined' && !('invokeNative' in window);

export async function fetchNui<TResponse = unknown, TBody = unknown>(
  event: string,
  body?: TBody,
  mockResponse?: TResponse,
): Promise<TResponse> {
  if (isEnvBrowser()) {
    // Helpful when running `npm run dev`
    console.info(`[fetchNui:${event}]`, body);
    if (mockResponse !== undefined) {
      return mockResponse;
    }
    return Promise.resolve({} as TResponse);
  }

  const response = await fetch(`https://${resourceName}/${event}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body ?? {}),
  });

  if (!response.ok) {
    throw new Error(`NUI callback ${event} responded with ${response.status}`);
  }

  return (await response.json()) as TResponse;
}

export const getResourceName = () => resourceName;
