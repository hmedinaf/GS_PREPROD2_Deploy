@isTest public class InvocableCrash_Test {

    static testmethod void testCrash() {

        try {   

            InvocableCrash.execute(new String[] {'Hello there!'});

            System.assert(false, 'Method did not cause a crash');

        } catch (InvocableCrash.InvocableCrashException ex) {

            //All good!

        }

    }

}