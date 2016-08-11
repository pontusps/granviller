scatter_heatmap <- function(xvalues, yvalues, xlabel, ylabel, alphaval = 1, xlimits = c(0,1), ylimits = c(0,1)) {
  
  #' Scatter Heat Map
  #'
  #' Function to plot a scatter plot where each point is coloured by its 2-dimensional density.
  #' Points beyond the limits will be sucked in to the edge values to depict that there exists more 
  #' beyond the edge of the plot.
  #'
  #' @param xvalues X values
  #' @param yvalues Y values
  #' @param xlabel X axis label
  #' @param ylabel Y axis label
  #' @param alphaval The transparency of the points
  #' @param xlimits Vector including limits of the x axis
  #' @param ylimits Vector including limits of the x axis
  #'
  #' @return Returns the ggplot2 plot
  #'
  #' @examples
  #' 
  #' x = rnorm(n = 50000, mean = 2, sd = 1)
  #' y = rexp(50000, 1)
  #' 
  #' scatter_heatmap(x, y, 'X Values', 'Y Values', 1, c(0,3.5), c(-0.1, 8) )
  #'
  #' @export
  
  datadf <- data.frame(xvals = xvalues, yvals = yvalues)
  
  datadf = limit_df(datadf, c(xlimits(1), xlimits(2)), 1 )
  datadf = limit_df(datadf, c(ylimits(1), ylimits(2)), 2 )
  
  datadf$dens <- densCols(datadf$xvals, datadf$yvals, colramp = colorRampPalette(rev(RColorBrewer::brewer.pal(11,'Spectral'))))
  
  plot <- ggplot(datadf) + 
    geom_point(aes(y = yvals, x = xvals, col = dens), alpha=alphaval) + 
    ylim(ylimits[1],ylimits[2]) + 
    xlim(xlimits[1],xlimits[2]) + 
    scale_color_identity() + 
    xlab(xlabel) + ylab(ylabel)
  
  return(plot)
  
}