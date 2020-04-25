define i64 @fib(i64) local_unnamed_addr #0{
    %2 = icmp slt i64 %0, 2
    br i1 %2, label %9, label %3
; <label>:3:                    ; preds = %1
    %4 = add nsw i64 %0, -1
    %5 = tail call i64 @fib(i64 %4) 
    %6 = add nsw i64 %0, -2
    %7 = tail call i64 @fib(i64 %6) 
    %8 = add nsw i64 %7, %5
    ret i64 %8
; <label>:9:                    ; preds = %1
    ret i64 %0
}
