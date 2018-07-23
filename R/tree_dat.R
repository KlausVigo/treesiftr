#' Generate likelihood and parsimony scores for each tree.
#' @description  Generate extra data, including likelihood and parsimony scores for each tree. Export the values as tree annotation to put into the ggplot object.
#' @param tree Exported tree from parsimony search
#' @param data_set Phylogenetic matrix
#' @param start Which character to begin sampling characters at
#' @param stop Which character to end sampling characters at
#' @param pscore Boolean calculate and export parsimony scores for each character set
#' @param lscore Boolean calculate and export likelihood scores for each character set
#' @return tree Tree object with p and l scores annotated via $
#' @examples
#' tree <- generate_tree_vec(bears, 1, 2, starting_tree)
#' @export


tree_dat <-function(tree, phy_mat, start, stop, pscore = FALSE, lscore = FALSE, pri_score= FALSE){
  phy_mat <- phyDat(phy_mat, levels = c(0, 1), type = "USER")
  char_set <- c(start, stop)
  small_mat <- subset(phy_mat, select=char_set)
  if (pscore == TRUE){
   p_score <- fitch(tree, small_mat)
   tree$pars <- p_score
   }
  if (lscore == TRUE){
    tree <- multi2di(tree)
    tree <- acctran(tree, data = small_mat)
    fit = pml(tree, data = small_mat)
    print(fit)
    tree$lik <- fit$logLik
  }
  return(tree)
}