anova.pgls.fixed <- function (object) 
{
	data <- object$data
	tlabels <- attr(terms(object$formula), "term.labels")
	k <- object$k
	n <- object$n
	NR <- length(tlabels) + 1
	rss <- resdf <- rep(NA, NR)
	rss[1] <- object$NSSQ
	resdf[1] <- n - 1
	lm <- object$param["lambda"]
	dl <- object$param["delta"]
	kp <- object$param["kappa"]
	for (i in 1:length(tlabels)) {
		fmla <- as.formula(paste(object$namey, " ~ ", paste(tlabels[1:i], collapse = "+")))
		plm <- pgls(fmla, data, lambda = lm, delta = dl, kappa = kp)
		rss[i + 1] <- plm$RSSQ
		resdf[i + 1] <- (n - 1) - plm$k + 1
	}
	ss <- c(abs(diff(rss)), object$RSSQ)
	df <- c(abs(diff(resdf)), n - k)
	ms <- ss/df
	fval <- ms/ms[NR]
	P <- pf(fval, df, df[NR], lower.tail = FALSE)
	table <- data.frame(df, ss, ms, f = fval, P)
	table[length(P), 4:5] <- NA
	dimnames(table) <- list(c(tlabels, "Residuals"), c("Df", "Sum Sq", "Mean Sq", "F value", "Pr(>F)"))
	structure(table, heading = c("Analysis of Variance Table", sprintf("Sequential SS for pgls: lambda = %0.2f, delta = %0.2f, kappa = %0.2f\n", lm, dl, kp), paste("Response:", deparse(formula(object)[[2L]]))), class = c("anova", "data.frame"))
}