/**
 * Passport Google OAuth 2.0 Configuration
 */

import passport from 'passport';
import { Strategy as GoogleStrategy } from 'passport-google-oauth20';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// Serialize user into session
passport.serializeUser((user: any, done) => {
  done(null, user.id);
});

// Deserialize user from session
passport.deserializeUser(async (id: string, done) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        googleId: true,
        email: true,
        name: true,
        picture: true
      }
    });
    done(null, user);
  } catch (error) {
    done(error, null);
  }
});

// Google OAuth 2.0 Strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID!,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    callbackURL: process.env.GOOGLE_CALLBACK_URL || '/auth/google/callback'
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      // Check if user exists
      let user = await prisma.user.findUnique({
        where: { googleId: profile.id }
      });

      if (!user) {
        // Create new user
        user = await prisma.user.create({
          data: {
            googleId: profile.id,
            email: profile.emails?.[0]?.value || '',
            name: profile.displayName,
            picture: profile.photos?.[0]?.value
          }
        });
        
        console.log('✓ New user created:', user.email);
        
        // Create default active semester for new user
        await prisma.semester.create({
          data: {
            userId: user.id,
            name: 'Current Semester',
            isActive: true
          }
        });
      } else {
        // Update user info if changed
        user = await prisma.user.update({
          where: { id: user.id },
          data: {
            name: profile.displayName,
            picture: profile.photos?.[0]?.value
          }
        });
      }

      return done(null, user);
    } catch (error) {
      console.error('OAuth error:', error);
      return done(error as Error, undefined);
    }
  }
));

export default passport;
