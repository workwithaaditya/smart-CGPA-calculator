import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

/**
 * Helper function to get authenticated user ID from session
 * Throws error if user is not authenticated
 */
export async function getUserId(): Promise<string> {
  const session = await getServerSession(authOptions);
  
  if (!session?.user?.id) {
    throw new Error('Unauthorized');
  }
  
  return session.user.id;
}
