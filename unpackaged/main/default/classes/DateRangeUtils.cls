public class DateRangeUtils {
    
    public static Boolean checkDateRangesOverlap(Date startDate1, Date endDate1, Date startDate2, Date endDate2) {
        // Check if the start date of range 1 is between the start and end dates of range 2
        if (startDate1 >= startDate2 && startDate1 <= endDate2) {
            return true;
        }
        
        // Check if the end date of range 1 is between the start and end dates of range 2
        if (endDate1 >= startDate2 && endDate1 <= endDate2) {
            return true;
        }
        
        // Check if the start date of range 2 is between the start and end dates of range 1
        if (startDate2 >= startDate1 && startDate2 <= endDate1) {
            return true;
        }
        
        // Check if the end date of range 2 is between the start and end dates of range 1
        if (endDate2 >= startDate1 && endDate2 <= endDate1) {
            return true;
        }
        // No overlap found
        return false;
    }
}