package operations.viewfeedback;

import java.util.List;
import model.FeedbackPojo;

public interface FeedbackInterface {
    List<FeedbackPojo> getFeedbacksByCustomerId(int customerId);
}